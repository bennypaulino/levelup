Levelup::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  resource :dashboard, only: [:show]
  root 'static_pages#index'
  get 'privacy', to: 'static_pages#privacy'
  get 'careers', to: 'static_pages#careers'
  get 'team', to: 'static_pages#team'
  resources :courses, only: [:index, :show] do
    resources :enrollments, only: :create
  end

  resources :lessons, only: [:show]
  
  namespace :instructor do
    resources :sections, only: [:update]
    resources :lessons, only: [:update]
    resources :sections, only: [] do
      resources :lessons, only: [:create]
    end
    resources :courses, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :sections, only: [:create]
    end
  end
end