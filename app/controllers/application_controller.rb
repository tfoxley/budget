class ApplicationController < ActionController::Base
  protect_from_forgery
  include Mobylette::RespondToMobileRequests

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  require "base64"
  
  def authorize
    @password = cookies['toolbox']
    @password ||= ''
    if Base64.decode64(@password) == PASSKEY
      true
    else
       redirect_to '/login'
    end
  end
end

