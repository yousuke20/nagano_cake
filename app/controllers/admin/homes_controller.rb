class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    # ヘッダーから遷移した場合　全顧客の注文履歴
    @order_all = Order.page(params[:page]).reverse_order
    # 会員詳細から遷移した場合　その顧客のみの注文履歴
  end
  
end
