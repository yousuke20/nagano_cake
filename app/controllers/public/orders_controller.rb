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
     @address = Address.new
     @order = Order.new
   end
   
   # 注文情報入力画面にて新規配送先の登録
   def create_address
     @address = Address.new(create_address_params)
     @address.customer_id = current_customer.id
     if @address.save
       flash[:success] = '新規配送先を保存しました<br>「登録済住所から選択」のセレクトボタン内にデータが格納されます。'
       redirect_to new_order_path
     else
     end   
   end
   
   # 注文確認ページ、注文情報入力ページで入力したお支払い方法、お届け先の一時保持（session）
   def confirm
     @order = current_customer.orders
     @total_price = calculate(current_customer)
     
     session[:payment_method] = params[:payment_method]
     
     if params[:add] == "my_address"
       session[:address] = "〒" + current_customer.postal_code + current_customer.address + current_customer.last_name + current_customer.first_name
     elsif params[:add] == "choise_address"
       session[:address] = "〒" + params[:address]
     else
       render :new
     end
   end
   
   def create
    # 注文内容の保存
     @order = Order.new
     @order.customer_id = current_customer.id
     @order.address = session[:address]
     @order.postal_code = nil
     @order.name = nil
     @order.shipping_cost = 800
     @order.payment_method = session[:payment_method]
     @order.payment = calculate(current_customer)
     @order.status = 1
     @order.save
    # 注文商品ごとの詳細の保存
     current_customer.cart_items.each do |cart|
       @order_detail = OrderDetail.new
       @order_detail.order_id = @order.id
       @order_detail.item_id = cart.item.id
       @order_detail.price = cart.item.price
       @order_detail.amount = cart.amount
       @order_detail.making_status = 3
       @order_detail.save
     end
    # 現ユーザーのカート内データ、および支払い方法＆お届け先データの削除
     current_customer.cart_items.destroy_all
     session.delete(:payment_method)
     session.delete(:address)
     flash[:success] = '注文処理が完了しました！'
     redirect_to orders_complete_path
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
    params.permit(
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
