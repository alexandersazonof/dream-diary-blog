Rails.application.routes.draw do
  root 'home#index'

  get '/show', to: 'home#show', as: 'show'
  get '/search', to: 'home#search', as: 'search'

  resources :posts do
    resources :comments
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
