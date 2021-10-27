Rails.application.routes.draw do
  match '*all', controller: 'application', action: 'cors_preflight_check', via: :options

  scope module: 'api', format: 'json' do
    namespace :v1 do
      post 'authentication/create'
      post 'sessions/create'
      resources :invoices, only: %i[create show index]
    end
  end
end
