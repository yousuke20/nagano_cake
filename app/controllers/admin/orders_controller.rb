class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @detail = @order.order_details
    @order.update(order_params)
    
    # 注文ステータスを「入金確認」にしたとき、製作ステータスが「製作待ち」に更新される処理
    if @order.status == "入金確認"
      @detail.update_all(making_status: "製作待ち")
      flash[:success] = '注文ステータス「入金確認」、製作ステータス「製作待ち」に更新しました！'
      redirect_to admin_order_path(@order)
      
    # 注文ステータスを「発送済み」にしたとき、注文ステータスが「発送済み」に更新される処理
    elsif @order.status == "発送済み"
      flash[:success] = '注文ステータスを「発送済み」に更新しました！'
      redirect_to admin_order_path(@order)
      
    # 上記2つ以外の注文ステータスを選択した場合
    else
      flash[:success] = '注文ステータスを更新しました！'
      redirect_to admin_order_path(@order)
    end  
  end

  # 注文ステータス・着手状況の更新に関するストロングパラメータ
  private

  def order_params
    params.require(:order).permit(:status)
  end

end
