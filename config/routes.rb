Rails.application.routes.draw do
  resources :accounts
  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users/:id' => 'devise/registrations#update', as: 'user_registration'
  end
  post 'resend_invitation/:user_id' => 'users#resend_invitation', as: 'resend_invitation'

  root 'charts#history'
  get 'experience', to: 'charts#experience'
  resources :employees, except: [:destroy] do
    resources :salaries, only: [:new, :create, :destroy]
  end

  resources :users, only: [:index]
end
