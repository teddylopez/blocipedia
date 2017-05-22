Rails.application.routes.draw do

  resources :wikis
  get 'about' => 'welcome#about'
  root to: "welcome#index"

  devise_for :users

end
