Rails.application.routes.draw do
  mount_devise_token_auth_for 'User',
    at: 'api/auth',
    controllers: {
      omniauth_callbacks:
        'overrides/omniauth_callbacks'
    }
  mount ActionCable.server => '/cable'
  scope :api do
    resources :streams
    resources :calls

    resources :casts do
      collection do
        get :mock_show
      end
    end

    resources :users do
      resources :streams, module: :users
      collection do
        get :current
        get :test
      end
    end

    namespace :platforms do
      namespace :youtube do
        resources :streams
      end
    end
  end
end
