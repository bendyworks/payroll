Rails.application.routes.draw do
  root 'charts#history'
  get 'experience', to: 'charts#experience'
end
