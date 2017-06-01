Rails.application.routes.draw do

  devise_for :users
  resources :wikis
  resources :charges, only: [:new, :create]

  get 'downgrade' => 'user#downgrade'
  get 'about' => 'welcome#about'
  root to: "welcome#index"



end
