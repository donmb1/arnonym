class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  private

  def poll_session
    @poll_session ||= Poll.find_by_code(session[:code]) if session[:code]
  end
  
  def admin_session
    @admin_session ||= Poll.find_by_code(session[:code_admin]) if session[:code_admin]
  end

  helper_method :poll_session
  helper_method :admin_session
  
end
