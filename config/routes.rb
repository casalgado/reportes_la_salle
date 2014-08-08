ReportesLaSalle::Application.routes.draw do
  
  get "lecture_days/edit"
  get "lecture_days/destroy"
  # devise routes
  devise_for :users

  devise_scope :user do
  root to: "devise/sessions#new"
  end

  # lecture routes

  resources :lectures do
    get 'my_lectures', :on => :member
    get 'my_reports' , :on => :member
  end

  # lecture_day routes

  resources :lecture_days
  
end
