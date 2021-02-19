class ApplicationController < ActionController::Base
  add_flash_types = :success, :info, :warning, :danger
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  # ログアウト後のパス設定
  def after_sign_out_path_for(resource)
    if resource == :admin
      flash[:success] = 'ログアウトしました！'
      new_admin_session_path
    else
      flash[:success] = 'ログアウトしました！'
      root_path
    end
  end
  
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
    keys: [
      :last_name, 
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :telephone_number,
      :is_active,
      ])
  end
end
