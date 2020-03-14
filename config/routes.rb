Rails.application.routes.draw do
 
  get 'addresses/new'
  get 'addresses/create'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end

  
  root 'experiment#index' 
  
end
