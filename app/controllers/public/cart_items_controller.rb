class Public::CartItemsController < ApplicationController
   before_action :authenticate_customer!

   def index
     @cart_items = current_customer.cart_items
     @total_price = calculate(current_customer)
   end

   def create
     @cart_item = CartItem.new
     @cart_item.customer_id = current_customer.id
     @cart_item.item_id = params[:item_id].to_i
     @cart_item.amount = params[:amount].to_i
     @cart_item.save
     flash[:success] = '選択した商品をカートに入れました！<br>「個数選択」より、数量を設定してください'
     redirect_to cart_items_path
   end

   def update
     @cart_item = CartItem.find(params[:id])
     @cart_item.update(cart_item_params)
     flash[:success] = '数量を変更しました！'
     redirect_to cart_items_path
   end

   def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    flash[:success] = '選択した商品をカートから削除しました！'
    redirect_to cart_items_path
   end

   def destroy_all
    current_customer.cart_items.destroy_all
    flash[:success] = 'カート内商品を全て削除しました！'
    redirect_to cart_items_path
   end

  # カート内商品のストロングパラメータ
   private

   def cart_item_params
     params.permit(:amount, :item_id, :customer_id)
   end
   
   def calculate(customer)
     total_price = 0
     customer.cart_items.each do |cart_item|
       total_price += (cart_item.amount).to_i * (cart_item.item.price) 
     end
     return (total_price * 1.1).floor
   end
end
