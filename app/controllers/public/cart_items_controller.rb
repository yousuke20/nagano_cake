class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer!

   def index
     @cart_items = current_customer.cart_items
     
     # カート小計の合計金額を算出
     @total_price = @cart_items.sum{|cart_item|(cart_item.item.price * cart_item.amount * 1.1)}
   end

   def create
     @cart_item = CartItem.new(cart_item_params)
     @cart_item.customer_id = current_customer.id
     @cart_item.item_id = params[:item_id]
     @cart_item.save
     redirect_to cart_items_path
   end

   def update
     @cart_item = CartItem.find(params[:id])
     @cart_item.update(cart_item_params)
     redirect_to cart_items_path
   end

   def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items
   end

   def all_destroy
    @cart_item_all = CartItem.all
    @cart_item_all.destroy
    redirect_to cart_items
   end

  # カート内商品のストロングパラメータ
   private

   def cart_item_params
     params.permit(:amount, :item_id, :customer_id)
   end
end
