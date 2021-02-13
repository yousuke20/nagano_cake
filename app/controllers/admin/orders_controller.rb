class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end

  # 注文ステータス・着手状況の更新に関するストロングパラメータ
  private

  def order_params
    params.require(:order).permit(:payment_method)
  end

end
