Rails.application.routes.draw do
  
  # 顧客側のパス
  devise_for :customers, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords'
  }
  
  
  # 管理者側のパス
  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
    registration: 'admin/registration',
    passwords: 'admin/passwords'
  }
    
  namespace :admin do
    root to: 'homes#top'
    
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end  
  
end
