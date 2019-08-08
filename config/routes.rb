Rails.application.routes.draw do
  resources :users
  resource :session
  resources :categories do
    resources :exams
  end
  resources :tests
  resources :randoms, except: [:index]
  resources :test_answers, only: [:index, :update]

  get "/home", to: "randoms#index", as: "user_home"
  get "/admin", to: "statics#index"
  get "exams", to: "exams#index"

  root to: "randoms#index"
end
