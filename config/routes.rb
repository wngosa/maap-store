require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  mount Sidekiq::Web => '/sidekiq'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV.fetch('SIDEKIQ_USER', 'user') &&
      password == ENV.fetch('SIDEKIQ_PASSWORD', 'password')
  end
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: { sessions: 'api/v1/sessions' }

      resources :users, only: [] do
        collection do
          get :me
        end
      end
      resources :sites, only: [:index, :create]
      resources :lab_record_imports, only: [:create, :update]
      resources :specimen_sources, only: [:index]
      resources :culture_types, only: [:index]
      resources :antibiotic_consumption_stats, only: [:index, :create, :update]
      resources :antibiotics, only: [:index, :create, :update]
      resources :patients, only: [:index, :create, :update]
      resources :clinical_services, only: [:index]
      resources :patient_entries, only: [:index, :create, :update]
      resources :patient_locations, only: [:index, :create, :update]
      resources :electronic_pharmacy_stock_records, only: [:create]
    end
  end
  root :to => "status#index"
end
