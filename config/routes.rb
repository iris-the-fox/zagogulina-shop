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

  get '*path', to: 'errors#error_404', via: :all

end
