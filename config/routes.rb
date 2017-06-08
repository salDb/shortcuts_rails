Rails.application.routes.draw do
  post "/signup" => "users#create"
  put "/update_account" => "users#update"
  post "/login" => "sessions#create"

  resources :apps do
    resources :shortcuts, except: [:show]
  end
end
