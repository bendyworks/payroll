Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users/:id' => 'devise/registrations#update', as: 'user_registration'
  end
  post 'resend_invitation/:user_id' => 'users#resend_invitation', as: 'resend_invitation'

  root 'charts#salaries'
  get 'balances', to: 'charts#balances'
  get 'salaries', to: 'charts#salaries'
  get 'experience', to: 'charts#experience'

  resources :employees, except: [:destroy] do
    resources :salaries, only: [:new, :create, :destroy]
  end

  resources :users, only: :index
  resources :accounts, except: :index do
    collection do
      get :upload_balances_form
      post :upload_balances
    end
  end
end
