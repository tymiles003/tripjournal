Rails.application.routes.draw do
  root to: 'feeds#index'

  get '/notes',             to: 'notes#index',      as: :notes

  get  '/track',            to: 'api/points#create'

  get  '/import',           to: 'import#show',      as: :import
  post '/import/instagram', to: 'import#instagram', as: :import_instagram
  post '/import/gpx',       to: 'import#gpx',       as: :import_gpx

  get  '/oauth/instagram/connect',  to: 'oauth#connect_instagram', as: :instagram
  get  '/oauth/instagram/callback', to: 'oauth#instagram',         as: :instagram_callback

  namespace :api do
    resources :points, only: [:index, :create]
  end
end
