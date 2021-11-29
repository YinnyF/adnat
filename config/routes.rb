Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'welcome#home'

  devise_for :users

  resources :shifts

  resources :organisations do
    resources :memberships
  end

end
