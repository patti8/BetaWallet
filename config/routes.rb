Rails.application.routes.draw do
  devise_for :users
  
  root 'dashboard#activity'
  
 namespace :transactions do 

    get "/toFriend", to: "transfer#friend"
    post "/sendMoney", to: "transfer#sendMoney"

    resources :deposit, only: [:create]
    get "history/:id_team", to: "deposit#history", :as => "deposit_history"
    
    resources :withdraw, only: [:new, :create, :show]

 end


 resources :teams do 
    resources :members, only: [:new, :create]
 end




end
