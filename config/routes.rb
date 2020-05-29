Rails.application.routes.draw do
  resources :videos, only: [:index, :show, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]
  post "/rentals/check-in", to: "rentals#checkin", as: "checkin"
  post "rentals/check-out", to: "rentals#checkout", as: "checkout"
end
