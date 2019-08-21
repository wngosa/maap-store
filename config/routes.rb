require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  mount Sidekiq::Web => '/sidekiq'
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
      resources :antibiotic_consumption_stats, only: [:index, :create]
      resources :antibiotics, only: [:index, :create]
      resources :patients, only: [:index, :create]
      resources :clinical_services, only: [:index]
      resources :patient_entries, only: [:index, :create, :update]
    end
  end
end
