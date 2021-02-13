class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_detail_params)
    redirect_to admin_order_path(@order)
  end
  
  # 製作ステータスの更新に関するストロングパラメータ
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
   
end