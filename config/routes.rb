Rails.application.routes.draw do
  resources :users
  resource :session
  resources :categories do
    resources :exams
  end
end
