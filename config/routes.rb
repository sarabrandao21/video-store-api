Rails.application.routes.draw do
  resources :videos, only: [:index, :show, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]
  resources :rentals, only: [:index]
  post "/rentals/check-in", to: "rentals#check-in", as: "check-in"
  post "rentals/check-out", to: "rentals#check-out", as: "check-out"
end
