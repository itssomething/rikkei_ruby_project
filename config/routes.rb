Rails.application.routes.draw do
  resources :users
  resource :session
  resources :categories do
    resources :exams
  end
  resources :tests
  resources :randoms, except: [:index]
  resources :test_answers, only: [:index, :update]
  resources :password_resets
  resources :user_activations, only: [:edit]

  get "/home", to: "randoms#index", as: "user_home"
  get "/admin", to: "statics#index"
  get "exams", to: "exams#index"
  get "/users_chart", to: "charts#user_creation_info"
  get "/tests_chart", to: "charts#tests_info"

  get "/upload-exam-file", to: "files#new"
  post "/upload-exam-file", to: "files#upload_exam"
  get "/download_exam_template", to: "files#download_exam_template"

  post "/resend-email", to: "user_activations#create"
  
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  root to: "randoms#index"
end
