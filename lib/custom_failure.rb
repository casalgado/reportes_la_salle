  class CustomFailure < Devise::FailureApp

    def redirect_url
      return super unless [:coordinator].include?(scope) #make it specific to a scope
       static_pages_mail_confirmation_path
    end


    def respond
      if http_auth?
        http_auth
      else
        redirect
      end
    end
  end