Gitportal::Engine.routes.draw do
  resources :issues, only: %i[index show]
  resources :milestones, only: %i[index show]
  resources :pull_requests, only: %i[index show]
end
