class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!

   def show
     @customer = current_customer
   end 
   
   def edit
     @customer = Customer.find(params[:id])
   end
   
   def update
     @customer = Customer.find(params[:id])
     @customer.update(customer_params)
     redirect_to customer_path(current_customer)
   end
   
   def withdrawal
   end
   
   # ユーザーの退会処理（論理削除）、物理削除ではないため、pacthを用いてupdateする
   def destroy
   #  is_activeを2にし、「有効」から「退会」へ変える
     current_customer.update(is_active: 2)
   # ログアウトさせる
     reset_session
     redirect_to root_path
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
