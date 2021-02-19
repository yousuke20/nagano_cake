class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @detail = OrderDetail.find(params[:id])
    @detail.update(order_detail_params)
    flash[:success] = '製作ステータスを更新しました！'
    redirect_to admin_order_path(@detail.order.id)
  end
  
  # 製作ステータスの更新に関するストロングパラメータ
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
   
end