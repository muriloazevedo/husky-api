Rails.application.routes.draw do
  scope module: 'api', format: 'json' do
    namespace :v1 do
      resources :invoices, only: %i[create show index]
    end
  end
end
