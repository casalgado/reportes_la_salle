class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  # devise after sign_in/sign_up path
  def after_sign_in_path_for(resource)
    if current_user
 		my_lectures_lecture_path(resource)
    else
    reports_path
    end
	end

  def after_sign_up_path_for(resource)
    static_pages_mail_confirmation_path
  end


	# devise add :first_name, :last_name attributes
  before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) << :first_name
	  devise_parameter_sanitizer.for(:sign_up) << :last_name

    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
  end


end
