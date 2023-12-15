Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :delete] do
      resources :comments, only: [:new, :create, :delete]
      resources :likes, only: [:create]
    end
  end
end
