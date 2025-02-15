# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#top'
  # davise関係
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
    # registrations: 'users/registrations',
    # sessions: 'users/sessions',
  }

  # OAuthログイン関連
  post 'oauth/callback', to: 'oauths#callback'
  get 'oauth/callback', to: 'oauths#callback'
  get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider

  # 管理者関連
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  namespace :admin do
    root 'dashboards#index'
    resources :dashboards, only: [:index]
    resources :users, only: %i[index edit update destroy]
    resources :user_sessions, only: %i[new create destroy], path_names: { new: 'login', destroy: 'logout' }
  end

  # planページ
  resources :planners, only: %i[index new create show edit update destroy] do
    resources :schedules, only: %i[index new create show edit update destroy] do
    end
  end

  # mypage
  resource :mypage, only: %i[show edit update] do
    get 'submit_plans', to: 'users#submit_plans'
    get 'evaluated_plans', to: 'users#evaluated_plans'
    get 'email', to: 'users#edit_email', as: :edit_email
    patch 'email', to: 'users#update_email'
    get 'password', to: 'users#edit_password', as: :edit_password
    patch 'password', to: 'users#update_password'
  end
end
