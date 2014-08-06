ReportesLaSalle::Application.routes.draw do
  
  # devise routes
  devise_for :users

  devise_scope :user do
  root to: "devise/sessions#new"
  end

  # lecture routes

  resources :lectures

  resources :lectures,     only: [] do
    collection do
      get 'my_lectures'
    end
  end


end
