Rails.application.routes.draw do
  post "/register", to: "auth#register"
  post "/login", to: "auth#login"

  get "/me", to: "profiles#show"
  get "/mycourses", to: "courses#my_courses"   # <= added

  resources :courses do
    resources :lessons
    resources :feedbacks
  end

  resources :enrollments, only: [:create, :index, :destroy]
  resources :progresses
end