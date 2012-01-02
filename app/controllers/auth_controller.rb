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
      end
    end
  end
  
  def authorize
    if params[:password] == PASSKEY
      if(params[:persist])
        cookies['toolbox'] = { :value => Base64.encode64(params[:password]), :expires => 3.month.from_now }
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