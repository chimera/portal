Portal::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    delete "logout", to: "devise/sessions#destroy"
    get "signup", to: "devise/registrations#new"
  end

  resources :check_ins

  namespace "admin" do
    resources :check_ins
    resources :users
    get '', to: 'dashboard#index'
  end

  root to: 'pages#index'
end
