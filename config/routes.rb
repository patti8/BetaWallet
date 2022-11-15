Rails.application.routes.draw do
  devise_for :users
  
  root 'dashboard#activity'
  
 namespace :transactions do 

    get "/toFriend", to: "transfer#friend"
    post "/sendMoney", to: "transfer#sendMoney"

    resources :deposit, only: [:create]
    resources :withdraw, only: [:new, :create]

 end


 resources :teams do 
    resources :members
 end




end
