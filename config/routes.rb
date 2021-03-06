Rails.application.routes.draw do

resources :listings

root 'home#index'

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, only: [:show, :edit, :update, :destroy, :index]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  post "/listings/new", to: 'listings#new'
  get "/success", to: 'listings#success'
  get "/book", to: 'listings#book'
  post "/book", to: 'listings#book'
  post "/pay", to: 'payments#new'
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get 'tags/:tag', to: 'listings#index', as: :tag
  get '/search', to: 'listings#search'
  get '/payment', to: 'payments#new'
  post '/payments', to: 'payments#create'
end




