ReportesLaSalle::Application.routes.draw do
  

  
  # devise routes

  devise_for :users

  devise_scope :user do
  root to: "devise/sessions#new"
  end

  devise_for :coordinators

  devise_scope :coordinator do
  get    '/no-access'   => "devise/sessions#no_access",     as: :no_access
  end

  # lecture routes

  resources :lectures do
    get 'my_lectures', :on => :member
    get 'my_reports' , :on => :member
  end

  # lecture_day routes

  resources :lecture_days

  # report routes

  resources :reports

  
end
