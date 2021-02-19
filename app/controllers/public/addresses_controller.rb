class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @addresses = Address.all.order(created_at: :desc)
    @address = Address.new
  end
  
  def create
    @address = Address.new(add_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = '配送先登録が完了しました！'
      redirect_to addresses_path
    else
      flash[:danger] = '内容に不備があります！'
      render :index
    end  
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    if @address.update(add_params)
      flash[:success] = '編集内容を保存しました！'
      redirect_to addresses_path
    else
      flash[:danger] = '内容に不備があります！'
      render :edit
    end  
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:success] = '配送先登録を削除しました！'
    redirect_to addresses_path
  end
  # 宛名データのストロングパラメータ
  
  private
  
  def add_params
    params.require(:address).permit(:customer_id, :postal_code, :address, :name)
  end
end
