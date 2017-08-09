# frozen_string_literal: true

Rails.application.routes.draw do
  root 'charts#home'

  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users/:id' => 'devise/registrations#update', as: 'user_registration'
  end
  post 'resend_invitation/:user_id' => 'users#resend_invitation', as: 'resend_invitation'

  get 'home', to: 'charts#home'
  get 'balances', to: 'charts#balances'
  get 'salaries', to: 'charts#salaries'
  get 'experience', to: 'charts#experience'
  get 'planning', to: 'planning#index'

  resources :employees, except: [:index, :destroy] do
    resources :salaries, only: [:new, :create, :destroy]
  end

  resources :users, only: [:index, :destroy] do
    member do
      post :set_admin_status
    end
  end

  resources :accounts, except: :index do
    collection do
      get :upload_balances_form
      post :upload_balances
    end
  end
end
