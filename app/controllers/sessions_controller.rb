class SessionsController < ApplicationController
  def new
  end
  
  def create
    
    if params[:code]
      poll_auth = Poll.authenticate(params[:code], params[:password])
      if poll_auth
        session[:code] = params[:code]
        redirect_to '/' + params[:code], :notice => "Logged in!"
      else
        flash.now.alert = "Invalid email or password"
        redirect_to '/' + params[:code], :notice => "Invalid password!"
      end
    
    elsif params[:code_admin]
    
      admin_auth = Poll.authenticate_admin(params[:code_admin], params[:password_admin])
      if admin_auth
        session[:code_admin] = params[:code_admin]
        redirect_to '/' + params[:code_admin] + '/admin', :notice => "Logged in as admin!"
      else
        flash.now.alert = "Invalid email or password"
        redirect_to '/' + params[:code_admin] + '/admin', :notice => "Invalid password!"
      end
      
    end
    
  end

  
  def destroy
    session[:code] = nil
    redirect_to root_url, :notice => "Logged out from Poll!"
  end
  
  def destroy_admin
    session[:code_admin] = nil
    redirect_to root_url, :notice => "Logged out from Admin!"
  end
  
  def new_poll
    session[:code] = nil
    cookies.delete("last_poll")
    
    redirect_to root_url, :notice => "You got it. Make a new poll now."
  end
  
end
