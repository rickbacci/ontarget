require 'sidekiq/web'

Rails.application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  get '/home',                    to: 'home#show'
  get '/auth/github',             as: 'login'
  get '/auth/github/callback',    to: 'sessions#create'
  get '/logout',                  to: 'sessions#destroy'

  resources :projects, only: [:index, :show, :new, :create, :destroy]

  get '/projects/:id/issues/new', to: 'issues#new', as: :new_project_issue

  resources :issues, only: [:index, :create]
  patch '/repos/:owner/:repo/issues/:number', to: 'issues#update', as: :update_issue
  post  '/update_labels', to: 'issues#update_column'

  post '/repos/:owner/:repo/issues/:number/labels', to: 'issues#update_issue_labels', as: 'update_issue_labels'
  root 'dashboard#show'
end
