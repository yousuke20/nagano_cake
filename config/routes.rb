Rails.application.routes.draw do
  
  # 顧客側のパス
  devise_for :customers, path: 'customers',
  controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords'
  }
  
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    
    # カート内商品全削除
    delete '/cart_items/all' => 'cart_items#all_destroy'
    
    # 注文情報確認画面、注文完了画面
    post '/orders/confirm' => 'orders#confirm'
    get '/orders/complete' => 'orders#complete'
    
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:index, :create, :new, :show]
  end
  
  # 管理者側のパス
  devise_for :admins, path: 'admin',
  controllers: {
    sessions: 'admin/sessions',
    registration: 'admin/registrations',
    passwords: 'admin/passwords'
  }
    
  namespace :admin do
    root to: 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end  
  
end
