Rails.application.routes.draw do

  get '/home',                    to: 'home#show'
  get '/auth/github',             as: 'login'
  get '/auth/github/callback',    to: 'sessions#create'
  get '/logout',                  to: 'sessions#destroy'


  resources :issues, only: [:index, :new, :create, :edit]

  patch '/repos/:owner/:repo/issues/:id', to: 'issues#update'
  post  '/repos/:owner/:repo/issues/:number/labels', to: 'issues#add_label', as: :in_progress
  # post  '/in_progress', to: 'issues#add_label'

  root 'dashboard#show'
end
