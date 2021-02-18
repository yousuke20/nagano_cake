class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  
  def top
    # 遷移元(直前)のcontrollerやaction名を取得する
    @path = Rails.application.routes.recognize_path(request.referer)
    
    # 顧客の会員詳細ページ(admin/customers#show)「注文履歴一覧を見る」を押した場合、その顧客の注文履歴のみ表示される
    if @path[:controller] == "admin/customers" && @path[:action] = "show"
      @customer = Customer.find_by(@path[:id])
      @orders = Order.where(customer_id: @path[:id]).page(params[:page]).reverse_order
    else
      @orders = Order.all.page(params[:page]).reverse_order
    end
  end
  
end
