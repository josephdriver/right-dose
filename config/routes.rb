Rails.application.routes.draw do
  root 'pages#home'
  devise_for :paramedics, :skip => [:registrations], controllers: { sessions: 'paramedics/sessions' }
    as :paramedic do
      get 'paramedics/edit' => 'devise/registrations#edit', :as => 'edit_paramedic_registration'
      put 'paramedics' => 'devise/registrations#update', :as => 'paramedic_registration'
      end
  devise_for :admins, :skip => [:registrations], controllers: { sessions: 'admins/sessions' }
    as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    put 'admins' => 'devise/registrations#update', :as => 'admin_registration'
    end
  put '/edit_paramedic/:id', to: 'paramedics#update'
  patch '/edit_paramedic/:id', to: 'paramedics#update', as: 'edit_paramedic'
  get '/edit_paramedic', to: 'paramedics#edit'
  post '/add_paramedic', to: 'paramedics#create', as: 'add_paramedic'
  get 'admin_dashboard', to: 'dashboards#admin_dashboard', as: 'admin_dashboard'
  resources :paramedic_types, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :paramedics, only: [:index, :show, :new, :create, :destroy, :edit, :update]
  resources :organizations, only: [:edit, :update]

  resources :drugs, only: [:index, :new, :create, :destroy] do
  end

  resources :indications, only: [:new, :create, :destroy]

  resources :presentations, only: [:new, :create, :destroy]
  resources :presentations, only: [] do
  end

  resources :rules, only: [:index, :show, :new, :create, :destroy]
  get 'search/:drug_id', to: 'rules#search', as: :find_rules_path

  get 'paramedic_dashboard', to: 'dashboards#paramedic_dashboard', as: 'paramedic_dashboard'
  resources :cases, only: [:edit, :update] do
    resources :case_drugs, only: [:index, :create, :destroy]
  end
end
