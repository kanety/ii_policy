Rails.application.routes.draw do
  root to: "users#index"
  resources :users do
    collection do
      get :export
    end
  end
  resources :chain_users
end
