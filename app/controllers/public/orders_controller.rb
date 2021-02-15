class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
   
   def index
     
   end
   
   def new
     @order = Order.new
     @order.customer_id = current_customer.id
     @addresses = Address.where(customer_id: current_customer.id)
   end
   
   def confirm
     @order = Order.new(order_params)
     @order.save
     redirect_to 
   end
   
   def show
     
   end
  
   def create
      
   end
   
   def complete
     
   end
   
  # 注文データのストロングパラメータ
  private
  
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
