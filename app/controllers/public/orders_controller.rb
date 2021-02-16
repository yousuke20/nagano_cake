class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
   
   def index
     @orders = Order.where(customer_id: current_customer)
   end
   
   def show
     @order = Order.find(params[:id])
     @order_details = @order.order_details
   end
   
   def new
     @addresses = current_customer.addresses
     @address = Address.new
     @order = Order.new
   end
   
   def create
      # 注文データの一時保存
      session[:order] = Order.new
      @customer = current_customer
      @cart_items = current_customer.cart_items
      
      session[:order][:shipping_cost] = 800
      session[:order][:payment] = calculate(@customer)
      session[:order][:status] = 1
      session[:order][:customer_id] = @customer.id
      
      session[:order][:payment_method] = params[:payment_method] # ラジオボタンで選択した支払い方法の、enum番号を渡す
      
      @branch = params[:address_path].to_i # ラジオボタンで選択した配送先によって、条件分岐
      
      if @branch == 1  # ご自身の住所を選択した場合
        session[:order][:postal_code] = @customer.postal_code
        session[:order][:name] = @customer.last_name + @customer.first_name
        session[:order][:address] = @customer.address
        
      elsif @branch == 2   # 登録済住所を選択した場合
        @address = Address.find(params[:address])
        session[:order][:postal_code] = @address.postal_code
        session[:order][:name] = @address.name
        session[:order][:address] = @address.address
      end
      # お届け先入力に不備があった場合、情報入力画面へリダイレクト
      if session[:order][:postal_code].presence && session[:order][:name].presence && session[:order][:address].presence
        redirect_to new_order_path
      else  
        redirect_to orders_confirm_path
      end
    
   end
   
#   情報入力画面にて新規配送先の登録
   def create_address
     @address = Address.new(create_address_params)
     @address.customer_id = current_customer.id
     @address.save
     redirect_to new_order_path
   end
   
   def confirm
    @order = current_customer.orders
    @total_price = calculate(current_customer)
   end
   
   def complete
     
   end
   
  # 注文データのストロングパラメータ
  private
  
   def calculate(customer)
     total_price = 0
     customer.cart_items.each do |cart_item|
       total_price += cart_item.amount * cart_item.item.price
     end
     return (total_price * 1.1).floor
   end
  
  def create_address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
  
  def order_params
    params.require(:order).permit(
      :customer_id,
      :address,
      :name,
      :postal_code,
      :shipping_cost,
      :payment,
      :payment_method,
      :status
      )
  end
end
