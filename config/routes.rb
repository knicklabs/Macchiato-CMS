Macchiato::Application.routes.draw do
  root :to => "home#index"

  devise_for :users
  resources :users, :only => :show
  
  resources :admin, only: [:index]
  
  namespace :api do
    resources :users, defaults: { format: "json" } do
      member do
        put :restore
      end
      
      collection do
        get :deleted
        get :published
        get :unpublished
        get :search
        get :count
      end
    end
    
    resources :posts, defaults: { format: "json" } do
      member do
        put :restore
      end
      
      collection do
        get :deleted
        get :published
        get :unpublished
        get :search
        get :count
      end
    end
    
    resources :pages, defaults: { format: "json" } do
      member do
        put :restore
      end
      
      collection do
        get :deleted
        get :published
        get :unpublished
        get :search
        get :count
      end
    end
  end 
end