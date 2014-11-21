Rails.application.routes.draw do
  devise_for :users
  root 'charts#history'
  get 'experience', to: 'charts#experience'
  resources :employees, only: :show
end
