require 'url_constrainer'

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get 'confirm_email', to: 'users/registrations#confirm_email'
    get 'complete_profile', to: 'users/registrations#complete_profile'
  end

  resources :users, :only => [:index]
  constraints(UrlConstrainer.new) do
    resources :users, param: :username, path: '/', :only => [:show]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
