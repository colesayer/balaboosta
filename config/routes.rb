Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'static#index'
  get 'about', to: 'static#about'

  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :guests, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get '/guests/:id/add_tour', to: 'guests#new_tour'
  post '/guests/:id/add_tour', to: 'guests#add_tour'
  post '/guests/:id/edit_tour/:tour_id', to: 'guests#update_tour'
  get '/guests/:id/edit_tour/:tour_id', to: 'guests#edit_tour'
  delete "/guests/:id/remove_tour/:tour_id", to: 'guests#remove_tour'

  resources :tours, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end
