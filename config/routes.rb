Rails.application.routes.draw do
  resources :images
  resources :sub_categories
  resources :categories
  resources :reports
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
