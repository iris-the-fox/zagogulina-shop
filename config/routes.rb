Rails.application.routes.draw do
  resources :products
  resources :categories do
    collection do
      get :manage
      post :sort
    end
  end
  root to: 'pages#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
