Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#current_user_home'
  get 'about', to: 'static#about'

  # resources :sessions, only: [:create, :new, :destoy]
  get 'login', to: 'session#new'
  post 'session/create', to: 'session#create'
  delete 'sessions/destroy', to: 'session#destroy', as: 'logout'

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :guests, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get '/guests/:id/add_tour', to: 'guests#new_tour'
  post '/guests/:id/add_tour', to: 'guests#add_tour'
  post '/guests/:id/edit_tour/:tour_id', to: 'guests#update_tour'
  get '/guests/:id/edit_tour/:tour_id', to: 'guests#edit_tour'
  delete "/guests/:id/remove_tour/:tour_id", to: 'guests#remove_tour'

  resources :tours, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
