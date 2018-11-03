Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#current_user_home'
  get 'about', to: 'static#about'

  # resources :sessions, only: [:create, :new, :destoy]
  get 'login', to: 'session#new'
  post 'session/create', to: 'session#create'
  delete 'sessions/destroy', to: 'session#destroy', as: 'logout'

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get '/users/:id/homepage', to: 'users#homepage', as: 'homepage'
  get '/users/:id/edit_password', to: 'users#edit_password', as: 'change_password'
  patch '/users/:id/edit_password', to: 'users#update_password', as: 'update_password'

  resources :guests, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get '/guests/:id/add_tour', to: 'guests#new_tour'
  post '/guests/:id/add_tour', to: 'guests#add_tour'
  post '/guests/:id/edit_tour/:tour_id', to: 'guests#update_tour'
  get '/guests/:id/edit_tour/:tour_id', to: 'guests#edit_tour'
  delete "/guests/:id/remove_tour/:tour_id", to: 'guests#remove_tour'

  resources :tours, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get '/tours/:id/edit_tour/:guest_id', to: 'tours#edit_reservation'
  post '/tours/:id/edit_tour/:guest_id', to: 'tours#update_reservation'
  get '/tours/:id/add_guest', to: 'tours#new_guest'
  post '/tours/:id/add_guest', to: 'tours#add_guest'
  post '/tours/:id/approve_tour', to: 'tours#approve_tour', as: 'approve_tour'
  delete '/tours/:id/remove_guest/:guest_id', to: 'tours#remove_guest'


  resources :payments
end
