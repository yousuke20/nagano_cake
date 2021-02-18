class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @addresses = Address.all.order(created_at: :desc)
    @address = Address.new
  end
  
  def create
    @address = Address.new(add_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to addresses_path
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    @address = Address.find(params[:id])
    @address.update(add_params)
    redirect_to addresses_path
  end
  
  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path
  end
  # 宛名データのストロングパラメータ
  
  private
  
  def add_params
    params.require(:address).permit(:customer_id, :postal_code, :address, :name)
  end
end
