Rails.application.routes.draw do
  root 'pages#home'
  devise_for :paramedics
  devise_for :admins, :skip => [:registrations]
    as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    put 'admins' => 'devise/registrations#update', :as => 'user_registration'
    end

  post '/add_paramedic', to: 'paramedics#create', as: 'add_paramedic'
  get 'admin_dashboard', to: 'dashboards#admin_dashboard', as: 'admin_dashboard'
  resources :paramedic_types, only: [:index, :new, :create, :destroy]
  resources :paramedics, only: [:index, :show, :new, :create, :destroy]
  resources :organizations, only: [:edit, :update]

  resources :drugs, only: [:index, :new, :create, :destroy] do
  end

  resources :presentations, only: [:new, :create, :destroy]
  resources :presentations, only: [] do
    resources :indications, only: [:new, :create, :destroy]
  end

  resources :rules, only: [:index, :show, :new, :create, :destroy]
  get 'search/:drug_id', to: 'rules#search', as: :find_rules_path



  get 'paramedic_dashboard', to: 'dashboards#paramedic_dashboard', as: 'paramedic_dashboard'
  resources :cases, only: [:edit, :update] do
    resources :case_drugs, only: [:index, :create, :destroy]
  end
end
