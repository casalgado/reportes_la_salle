ReportesLaSalle::Application.routes.draw do
  

  
  get "static_pages/home"
  get "static_pages/mail_confirmation"
  
  # devise routes

  devise_for :users

  devise_scope :user do
    get 'home' => "devise/sessions#home", as: :home
    root to: "devise/sessions#new"
  end

  devise_for :coordinators

  devise_scope :coordinator do
    get  'no_access' => "devise/sessions#no_access", as: :no_access
  end

  # lecture routes

  resources :lectures do
    member do
      get :my_lectures
      get :my_reports
    end
  end

  # lecture_day routes

  resources :lecture_days

  # report routes

  resources :reports do
    get 'reports_list', :on => :member
    get 'download_report', :on => :collection
    get 'program_data', :on => :collection
    get 'course_data', :on => :collection
    get 'teacher_data', :on => :collection
  end

  
end
