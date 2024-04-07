Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: 'application#multi_magic'

  devise_for :users, defaults: { format: :json }, skip: :all
  devise_scope :user do
    # If you change these urls and helpers, you must change these files too:
    # - config/initializers/devise.rb#JWT Devise
    # - spec/support/authentication_helper.rb

    namespace :api, defaults: {format: :json} do
      namespace :v1 do
        resources :users do
          collection do
            get :activated_users
            put :reset_password
          end
        end

      end
    end
    post '/users/login' => 'sessions#create', as: :user_session
    delete '/users/logout' => 'sessions#destroy', as: :destroy_user_session
    post '/users/signup' => 'registrations#create', as: :user_registration
  end

  get '/(*path)', to: 'application#multi_magic', as: :multi_magic
end
