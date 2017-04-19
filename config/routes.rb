Rails.application.routes.draw do
  devise_for :users

  resources :plays do
    resources :reviews
  end

  root 'plays#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
