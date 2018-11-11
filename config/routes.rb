Rails.application.routes.draw do
  root 'home#index'
  post 'auth/register', to: 'users#register'
  post 'auth/login' , to: 'users#login'
  post 'auth/refresh', to: 'users#refresh'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
