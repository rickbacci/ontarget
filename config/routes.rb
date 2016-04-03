Rails.application.routes.draw do

  get '/home',                    to: 'home#show'
  get '/auth/github',             as: 'login'
  get '/auth/github/callback',    to: 'sessions#create'
  get '/logout',                  to: 'sessions#destroy'
  get '/auth/failure',            to: 'home#show'

  resources :projects, only: [:index, :show, :new, :create, :destroy]
  resources :issues,   only: [:index, :create]

  get '/projects/:id/issues/new',      to: 'issues#new',    as: :new_project_issue
  patch '/update_issues/:number',      to: 'issues#update', as: :update_issues
  post '/update_issue_labels/:number', to: 'issues#update_issue_labels', as: :update_issue_labels
  post '/update_issue_times/:issue_number/:time',  to: 'issues#update_issue_times', as: :update_issue_times

  post  '/update_card_status', to: 'issues#update_card_status'

  root 'dashboard#show'
end
