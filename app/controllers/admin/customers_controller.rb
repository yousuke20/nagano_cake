class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page]).reverse_order
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      if @customer.is_active == "有効"
        @customer.update(is_valid: true)
        flash[:success] = '会員情報の更新に成功しました！'
        redirect_to admin_customer_path(@customer)
      elsif @customer.is_active == "退会"
        @customer.update(is_valid: false)
        flash[:success] = '会員情報の更新に成功しました！'
        redirect_to admin_customer_path(@customer)
      end  
    else  
      flash[:danger] = '内容に不備があります！'
      render :edit
    end
  end
  
  # 会員情報の更新ストロングパラメータ
  private
  
  def customer_params
    params.require(:customer).permit(
      :last_name, 
      :first_name, 
      :last_name_kana, 
      :first_name_kana,
      :email,
      :encrypted_password,
      :postal_code,
      :address,
      :telephone_number,
      :is_active
    )
  end
  
end
