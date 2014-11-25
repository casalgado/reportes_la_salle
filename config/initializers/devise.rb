
Devise.setup do |config|

  config.mailer_sender = 'informedigital.app@gmail.com'

  require 'devise/orm/active_record'

  config.case_insensitive_keys = [ :email ]

  config.strip_whitespace_keys = [ :email ]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 10

  config.reconfirmable = false

  config.password_length = 4..128

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.scoped_views = true

  #config.email_regexp = /\A([\w\.%\+\-]+)@lci\.edu.co\z/i

  config.warden do |manager|
    manager.failure_app = CustomFailure
  end

  
end
