Rails.application.routes.draw do

  devise_for :users
  resources :wikis, :path => "notes"
  resources :contacts, only: [:new, :create]
  resources :charges, only: [:new, :create]
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
    get :autocomplete_user_email, :on => :collection
    collection do
      get 'search'
    end
  end

  get 'downgrade' => 'users#downgrade'
  get 'about' => 'welcome#about'
  get 'home' => 'welcome#home'
  root to: "welcome#home"
end
