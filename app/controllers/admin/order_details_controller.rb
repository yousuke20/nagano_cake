class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    @detail = OrderDetail.find(params[:id])
    @order = @detail.order
    @detail.update(order_detail_params)
    
    # 製作ステータスを1つ「製作中」にすると、注文ステータスが「製作中」に更新される処理
    if @detail.making_status == "製作中" 
      @order.update(status: "製作中")
      flash[:success] = '注文ステータス「製作中」、製作ステータス「製作中」に更新しました！'
      redirect_to admin_order_path(@detail.order.id)
  
    # 商品の個数と、製作ステータスを「製作完了」にした商品の個数が一致した場合、注文ステータスが「発送待ち」に更新される処理
    elsif @order.order_details.count == @order.order_details.where(making_status: "製作完了").count
      @order.update(status: "発送準備中")
      flash[:success] = '注文ステータス「発送準備中」、製作ステータス「製作完了」に更新しました！'
      redirect_to admin_order_path(@detail.order.id)
      
    # 製作ステータスを「製作不可」「製作待ち」とした場合
    else
      flash[:success] = '製作ステータスを更新しました！'
      redirect_to admin_order_path(@detail.order.id)
    end  
  end
  
  # 製作ステータスの更新に関するストロングパラメータ
  private
  
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
   
end