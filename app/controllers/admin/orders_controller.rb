class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:success] = '注文ステータスを更新しました'
    redirect_to admin_order_path(@order)
  end

  # 注文ステータス・着手状況の更新に関するストロングパラメータ
  private

  def order_params
    params.require(:order).permit(:status)
  end

end
