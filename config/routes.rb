ReportesLaSalle::Application.routes.draw do
  

  
  # devise routes

  devise_for :users

  devise_scope :user do
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
  end

  
end
