Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # root 'users#index'
  # get '/users/:id', to: 'users#show'
  # get 'users/:id/posts', to: 'posts#index'
  # get 'users/:id/posts/:post_id', to: 'posts#show'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  devise_scope :user do
    get '/users/sign_in', to: 'users/sessions#new'
    get '/users/sign_out', to: 'users/sessions#destroy'
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:new, :create, :index, :show, ] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#index"
end
