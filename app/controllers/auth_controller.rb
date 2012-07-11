class AuthController < ApplicationController
  require "base64"
  
  def login
    @password = cookies['toolbox']
    @password ||= ''
    if Base64.decode64(@password) == PASSKEY
      redirect_to '/'
    else
      respond_to do |format|
        format.html # login.html.erb
        format.mobile
      end
    end
  end
  
  def authorize
    if params[:password] == PASSKEY
      if(params[:persist])
        cookies['toolbox'] = { 
          :value => Base64.encode64(params[:password]), 
          :expires => 1.year.from_now#, 
          #:domain => controller.cookie_domain,
          #:secure => Rails.env.production?,
          #:httponly => true
        }
      else
        cookies['toolbox'] = Base64.encode64(params[:password])
      end
      redirect_to '/'
    else
       redirect_to '/login'
    end
  end
  
  def logout
    cookies.delete 'toolbox'
    redirect_to '/login'
  end
end