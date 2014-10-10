Rails.application.routes.draw do

  root :to => "home#index"
  
  namespace :cpanel do
    root :to => "users#index"
    resources :users
    resources :idols
    resources :boxes
    resources :cards
  end
  
  get 'agreement' => 'mobile#agreement'
  get 'privacy' => 'mobile#privacy'
  get 'support' => 'mobile#support'
  
end
