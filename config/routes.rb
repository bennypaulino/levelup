Levelup::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root 'static_pages#index'
  resources :courses, only: [:index, :show]
  namespace :instructor do
    resources :courses, only: [:new, :create, :show, :edit, :update, :destroy]
  end
end
