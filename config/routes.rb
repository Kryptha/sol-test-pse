Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :routes, only: :index do
    collection do
      get ':from', to: 'routes#show'
      get ':from/:to', to: 'routes#show'
    end
  end
end
