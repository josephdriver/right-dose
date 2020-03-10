Rails.application.routes.draw do
  root 'pages#home'
  devise_for :paramedics
  devise_for :admins

  get 'admin_dashboard', to: 'dashboards#admin_dashboard', as: 'admin_dashboard'
  resources :paramedic_types, only: [:new, :create, :destroy]
  resources :paramedics, only: [:new, :create, :destroy]
  resources :organizations, only: [:edit, :update]

  resources :drugs, only: [:new, :create, :destroy] do
    resources :presentations, only: [:new, :create, :destroy]
  end

  resources :presentations, only: [] do
    resources :indications, only: [:new, :create, :destroy]
  end

  resources :rules, only: [:new, :create, :destroy]

  get 'paramedic_dashboard', to: 'dashboards#paramedic_dashboard', as: 'paramedic_dashboard'
  resources :case, only: [:new, :create] do
    resources :case_drugs, only: [:create, :destroy]
  end
end
