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
     if @customer.update(customer_params)
       flash[:success] = '編集内容を保存しました！'
       redirect_to customer_path(current_customer)
     else
       flash[:danger] = '内容に不備があります！'
       render :edit
     end     
   end
   
   def withdrawal
   end
   
   # ユーザーの退会処理（論理削除） 物理削除ではないため、pacthを用いてupdateする
   def destroy
   #  is_activeを2にし、「有効」から「退会」へ変える
     current_customer.update(is_active: 2, is_valid: false)
   # ログアウトさせ、sessionデータをリセットする
     reset_session
     flash[:success] = '退会処理が完了しました！'
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
