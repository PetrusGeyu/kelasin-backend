Rails.application.routes.draw do
  post "/register", to: "auth#register"
  post "/login", to: "auth#login"

  get "/me", to: "profiles#show"
  get "/mycourses", to: "courses#my_courses"

  resources :courses do
    resources :lessons
    resources :feedbacks
    post "enroll", to: "enrollments#create"
    delete "enroll", to: "enrollments#destroy"
  end

  resources :enrollments, only: [:index]
  resources :progresses

  # ✅ Tambahkan ini di paling bawah:
  get "/", to: proc { [200, {}, ['Kelasin API is running']] }
end
