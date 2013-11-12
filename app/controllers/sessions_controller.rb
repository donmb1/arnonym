class SessionsController < ApplicationController
  def new
  end
  
  def create
    poll_auth = Poll.authenticate(params[:code], params[:password])
    if poll_auth
      session[:code] = params[:code]
      redirect_to '/' + params[:code], :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      redirect_to '/' + params[:code], :notice => "Invalid password!"
    end
    
  end
  
  def destroy
    session[:code] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
  def new_poll
    session[:code] = nil
    cookies.delete("last_poll")
    
    redirect_to root_url, :notice => "You got it. Make a new poll now."
  end
  
end
