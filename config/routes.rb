Rails.application.routes.draw do
  scope module: 'api', format: 'json' do
    namespace :v1 do
      post 'authentication/create'
      get 'sessions/create'
      resources :invoices, only: %i[create show index]
    end
  end
end
