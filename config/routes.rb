Rails.application.routes.draw do

  root :to => "home#index"
  
  namespace :cpanel do
    root :to => "users#index"
    resources :users
    resources :idols
    resources :boxes
    resources :cards
  end
  
  
end
