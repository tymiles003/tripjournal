Rails.application.routes.draw do
  root to: 'feeds#index'

  get '/track', to: 'api/points#create'
  get  '/import', to: 'import#show', as: :import
  post '/import', to: 'import#create'

  namespace :api do
    resources :points, only: [:index, :create]
  end
end
