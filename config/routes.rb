require 'url_constrainer'

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'confirm_email', to: 'users/registrations#confirm_email'
  end

  resources :users,               only: [:index]
  resources :posts,               except: [:index], param: :url_token
  resources :relationships,       only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  constraints(UrlConstrainer.new) do
    resources :users, param: :username, path: '/', only: [:show]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
