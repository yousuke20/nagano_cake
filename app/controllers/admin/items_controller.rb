class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @items = Item.page(params[:page]).reverse_order
  end
  
  def new
    @item = Item.new
  end
  
  # 商品データの保存
  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item)
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  # 商品データの更新
  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end
  
  # 商品データのストロングパラメータ
  private
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
  
end
