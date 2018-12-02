Rails.application.routes.draw do

  root 'teams#get_sample'
  post 'auth/register', to: 'users#register'
  post 'auth/login' , to: 'users#login'
  post 'auth/refresh', to: 'users#refresh'

  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#show'
  put 'users/:id', to: 'users#update'
  
  put 'users/avatar/:id', to: 'users#update'  

  get 'teams', to: 'teams#index'
  post 'teams', to: 'teams#create'  
  get 'teams/:id', to: 'teams#show'
  put 'teams/:id', to: 'teams#update'

end
