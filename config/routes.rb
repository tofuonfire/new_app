require 'url_constrainer'

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  devise_for :users, controllers: {
        registrations: 'users/registrations'
      }
  resources :users, :only => [:index]
  constraints(UrlConstrainer.new) do
    resources :users, param: :username, path: '/', :only => [:show]
  end
end
