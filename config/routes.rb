Rails.application.routes.draw do
  # authenticated :user, -> (User) {user.admin? || user.moderator?} do
  get 'dashboard/articles', to: 'dashboard#articles'
  get 'dashboard', to: 'dashboard#index'
    
  # end
  get 'search', to: 'search#index'

  resources :articles do
    resources :comments
  end

  resources :comments do
    resources :comments
  end

  devise_for :users
  devise_scope :user do
    get 'sign_up', to: 'devise/registrations#new'
    post 'sign_up', to: 'devise/registrations#create'
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    get 'sign_out', to: 'devise/sessions#destroy', as: :sign_out
    delete 'sign_out', to: 'devise/sessions#destroy'
    get 'account-settings', to: 'devise/registrations#edit'
    get 'forget-pass', to: 'devise/passwords#new'
    
  end
  root 'articles#index'
  get 'user/:id', to: 'users#show'
  get 'users', to: 'users#index'
  resources :user
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
