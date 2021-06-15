Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users 
  resources :users do
    post "/friendship/confirm", to: "friendships#confirm"
    delete "friendships/", to: "friendships#destroy"
    delete "friendships-request/", to: "friendships#destroy_invitation"
    resources :friendships, only: [:create, :destroy] 
  end

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
