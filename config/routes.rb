Rails.application.routes.draw do

  get '/home',                    to: 'home#show'
  get '/auth/github',             as: 'login'
  get '/auth/github/callback',    to: 'sessions#create'
  get '/logout',                  to: 'sessions#destroy'


  resources :issues, only: [:index, :new, :create, :edit]

  patch '/repos/:owner/:repo/issues/:id', to: 'issues#update'

  # add labels to an issue
  # post  '/repos/:owner/:repo/issues/:number/labels/:oldcolumn/:newcolumn', to: 'issues#update_column'
  post  '/update_labels', to: 'issues#update_column'



  post  '/repos/:owner/:repo/issues/:number/labels', to: 'issues#in_progress', as: :in_progress

  post '/repos/:owner/:repo/labels/:name', to: 'issues#update_label', as: :update_label

  root 'dashboard#show'

end
