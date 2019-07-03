require 'url_constrainer'

Rails.application.routes.draw do
  root 'static_pages#home'
  get '/about', to: 'static_pages#about'
  devise_for :users
  resources :users, :only => [:index]
  constraints(UrlConstrainer.new) do
    resources :users, param: :username, path: '/', :only => [:show]
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
