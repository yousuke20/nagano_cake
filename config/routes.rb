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
    
    delete '/cart_items/all' => 'cart_items#all_destroy' # カート内商品全削除
    
    # 注文情報確認画面、注文完了画面
    get '/orders/confirm' => 'orders#confirm', as: 'orders_confirm'
    get '/orders/complete' => 'orders#complete'
    
    # 情報入力画面での配送先登録用のアクション
    post '/orders/create_address' => 'orders#create_address' 
    
    # 顧客の退会確認画面、退会処理（ステータスの更新）
    post '/customers/confirm' => 'customers#confirm'
    patch '/customers/withdrawal' => 'customers#withdrawal'
    
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:index, :create, :new, :show]
    resources :customers, only: [:show, :edit, :update]
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
