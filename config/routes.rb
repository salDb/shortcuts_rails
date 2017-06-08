Rails.application.routes.draw do
  post "/signup" => "users#create"
  put "/update_account" => "users#update"
  post "/login" => "sessions#create"

  resources :apps
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
