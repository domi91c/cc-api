Rails.application.routes.draw do
  default_url_options :host => "localhost:4000"
  mount_devise_token_auth_for 'User',
    at: 'api/auth',
    controllers: {
      omniauth_callbacks:
        'overrides/omniauth_callbacks'
    }
  mount ActionCable.server => '/cable'
  scope :api do
    resources :streams do
      resources :requests, module: :streams
    end
    resources :calls

    resources :casts do
      collection do
        get :mock_show
      end
    end

    namespace :host do
      resources :streams do
        resources :requests, module: :streams
      end
    end

    resources :users do
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
