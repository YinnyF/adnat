Rails.application.routes.draw do
  root to: 'welcome#home'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :organisations do
    post 'memberships', to: 'memberships#create', as: 'join'
    delete 'memberships', to: 'memberships#destroy'
  end


end
