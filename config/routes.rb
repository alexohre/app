Rails.application.routes.draw do
  resources :articles
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
