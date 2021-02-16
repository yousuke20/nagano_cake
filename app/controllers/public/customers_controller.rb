class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!

   def show
   @customer = Customer.find(params[:id])
   end 
   
   def edit
     @customer = Customer.find(params[:id])
   end
   
   def update
     @customer = Customer.find(params[:id])
     @customer.update(customer_params)
     redirect_to customer_path(current_customer)
   end

   def confirm
     @customer = Customer.find(params[:id])
   end
   
   def withdrawal
     
   end
   
   # 顧客データのストロングパラメータ
   private
   
   def customer_params
     params.require(:customer).permit(
        :last_name,
        :first_name,
        :last_name_kana,
        :first_name_kana,
        :postal_code,
        :address,
        :telephone_number,
        :email
      )
   end
end
