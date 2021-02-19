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
    if @item.save
      flash[:success] = '商品データを保存しました！'
      redirect_to admin_item_path(@item)
    else
      flash[:danger] = '内容に不備があります！'
      render :new
    end  
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
    if @item.update(item_params)
      flash[:success] = '編集内容を保存しました！'
      redirect_to admin_item_path(@item.id)
    else
      flash[:danger] = "内容に不備があります！"
      render :edit
    end  
  end
  
  # 商品データのストロングパラメータ
  private
  
  def item_params
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end
  
end
