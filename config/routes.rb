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
  get "/users_chart", to: "charts#user_creation_info"
  get "/tests_chart", to: "charts#tests_info"

  root to: "randoms#index"
end
