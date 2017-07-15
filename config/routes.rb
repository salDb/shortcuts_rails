Rails.application.routes.draw do
  post "/signup" => "users#create"
  put "/update_account" => "users#update"
  post "/login" => "sessions#create"

  resources :apps, :defaults => { :format => :json } do
    resources :shortcuts, except: [:show], :defaults => { :format => :json }
  end
end
