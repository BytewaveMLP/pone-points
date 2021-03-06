# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  get  '/sign_in',  to: 'auth#sign_in'
  post '/sign_in',  to: 'auth#do_sign_in'
  get  '/sign_up',  to: 'auth#sign_up'
  post '/sign_up',  to: 'auth#do_sign_up'
  post '/sign_out', to: 'auth#sign_out'

  get  '/external/sign_up', to: 'auth#external_sign_up', as: :external_sign_up
  post '/external/sign_up', to: 'auth#do_external_sign_up', as: nil

  # External OAuth callback route.
  match '/auth/:provider/callback', to: 'auth#external', via: %i[get post]

  resources :points, only: [] do
    get :recent, on: :collection
  end

  resources :pones, only: %i[index show] do
    resources :points, only: %i[create], controller: 'pones/points' do
      get :give, on: :collection
    end
  end

  namespace :account, only: [] do
    resources :api_keys, only: %i[index show new create] do
      post :regenerate, on: :member
      post :revoke, on: :member
    end

    resources :webhooks, only: %i[index show new create destroy] do
      post :regenerate, on: :member
    end

    get   '/avatar', to: 'avatar#edit'
    patch '/avatar', to: 'avatar#update'
    post  '/avatar/remove', to: 'avatar#remove'

    get  :integrations
    get  :change_password
    post :change_password, action: :do_change_password
  end

  namespace :api do
    namespace :v1 do
      resources :pones, only: %i[index show], param: :slug do
        resources :achievements, only: :index, controller: 'pones/achievements'
        resources :points, only: %i[index show], controller: 'pones/points' do
          get :granted, on: :collection
          post :give, on: :collection
        end

        get :me, on: :collection
      end
    end
  end

  if defined?(Resque)
    require 'resque/server'

    admin_session_constraint = lambda { |request|
      request.session.send(:load!) unless request.session.loaded?

      result   = request.session[:pone_id]
      result &&= Pone.find_by(id: result)
      result &&= result.name == 'Minty Fresh' # TODO

      result
    }

    constraints(admin_session_constraint) do
      mount Resque::Server.new, at: '/admin/resque'
    end
  end
end
