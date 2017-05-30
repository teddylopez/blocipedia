Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create]
  get 'about' => 'welcome#about'
  root to: "welcome#index"

  devise_for :users

end
