Rails.application.routes.draw do

  get '/home',                    to: 'home#show'
  get '/auth/github',             as: 'login'
  get '/auth/github/callback',    to: 'sessions#create'
  get '/logout',                  to: 'sessions#destroy'
  get '/auth/failure',            to: 'home#show'

  resources :repos,  only: [:index]
  resources :issues, only: [:index, :create]

  get  '/repos/:repo_name', to: 'repos#show', as: :repo
  post '/repos/:repo_name/:has_issues', to: 'repos#create', as: 'create_repo'
  post '/repos/:repo_name', to: 'repos#activate_repo_issues', as: 'activate_repo_issues'

  get '/repos/:repo_name/issues/new',      to: 'issues#new',    as: :new_repo_issue

  patch '/update_issues/:repo/:number',      to: 'issues#update', as: :update_issues
  post '/update_issue_labels/:repo/:number', to: 'issues#update_issue_labels', as: :update_issue_labels
  post '/update_issue_times/:repo/:issue_number/:time',  to: 'issues#update_issue_times', as: :update_issue_times

  post  '/update_card_status', to: 'issues#update_card_status'

  root 'dashboard#show'
end
