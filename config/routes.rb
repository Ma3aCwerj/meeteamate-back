Rails.application.routes.draw do
  post 'auth/register', to: 'users#register'
  post 'auth/login' , to: 'users#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
