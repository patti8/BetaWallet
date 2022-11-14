Rails.application.routes.draw do
  devise_for :users
  
  root 'dashboard#activity'
  
 namespace :transactions do 
    get "/toFriend", to: "transfer#friend"
    post "/sendMoney", to: "transfer#sendMoney"
 end



end
