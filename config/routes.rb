Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: 'application#multi_magic'


  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :note_app do
        resources :notes do
          member do
            put :restore
            delete :destroy_permanently
          end

          put :invite_user_toggle
          put :toggle_tag
          post :create_and_assign_tag
          collection do
            get :tags
            get :trashes

          end
        end
      end

      resources :users do
        collection do
          get :activated_users
          put :reset_password
        end
      end

    end
  end

  devise_for :users, defaults: { format: :json }, skip: :all

  devise_scope :user do
    # If you change these urls and helpers, you must change these files too:
    # - config/initializers/devise.rb#JWT Devise
    # - spec/support/authentication_helper.rb
    post '/users/login' => 'sessions#create', as: :user_session
    delete '/users/logout' => 'sessions#destroy', as: :destroy_user_session
    post '/users/signup' => 'registrations#create', as: :user_registration
  end

  get '/*path', to: 'application#multi_magic', as: :multi_magic, constraints: -> (req) { !(req.fullpath.start_with?('/rails/')) }
end
