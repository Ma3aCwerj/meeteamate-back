Rails.application.routes.draw do

  root 'home#index'
  post 'auth/register', to: 'users#register'
  post 'auth/login' , to: 'users#login'
  post 'auth/refresh', to: 'users#refresh'

  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  put 'users/:id', to: 'users#update'
  
  put 'users/avatar/:id', to: 'users#update'  

  resources :teams
end
