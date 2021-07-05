Rails.application.routes.draw do
  root to: "items#index"
  resources :items do
    collection do
      get :export
    end
  end
  resources :chain_items
end
