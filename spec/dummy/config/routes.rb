Rails.application.routes.draw do
  root to: "items#index"
  resources :items do
    collection do
      get :export
    end
  end
  resources :coactive_items
end
