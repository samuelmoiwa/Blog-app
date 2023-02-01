Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'users#index'
  get '/users/:id', to: 'users#show'
  get 'users/:id/posts', to: 'posts#index'
  get 'users/:id/posts/:post_id', to: 'posts#show'
  
  # Defines the root path route ("/")
  # root "articles#index"
end
