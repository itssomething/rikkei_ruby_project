Rails.application.routes.draw do
  resources :users
  resource :session
  resources :categories do
    resources :exams
  end
  resources :tests
  resources :randoms, except: [:index]

  get "/home", to: "randoms#index", as: "user_home"
  get "/admin", to: "statics#index"
end
