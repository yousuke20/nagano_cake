class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer!
   
   def index
     @cart_items = CartItem.all
   end
   
   def create
     @cart_item = CartItem.new(cart_item_params)
     @cart_item.customer_id = current_customer.id
     @cart_item.item_id = params[:id]
     @cart_item.save
     redirect_to cart_items_path
   end
   
   def update
     
   end
   
   def destroy
    
   end
   
   def all_destroy
     
   end
   
  # カート内商品のストロングパラメータ
   private
   
   def cart_item_params
     params.require(:cart_item).permit(:amount)
   end
end
