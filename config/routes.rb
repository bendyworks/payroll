Rails.application.routes.draw do
  devise_for :users, skip: [:registrations]
  as :user do
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    patch 'users/:id' => 'devise/registrations#update', as: 'user_registration'
  end

  root 'charts#history'
  get 'experience', to: 'charts#experience'
  resources :employees, except: [:destroy] do
    resources :salaries, only: [:new, :create]
  end
end
