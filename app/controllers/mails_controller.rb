class MailsController < ApplicationController

  skip_before_filter :verify_authenticity_token 
  
  def mail_friends

    if params[:mail_friends][:skip_mailing] == "true"
  
      # set cookie so we know this form was filled out
      cookies["mailed-" + params[:mail_friends][:poll_code]] = true
      render "home/index"
  
    else
    
      # send mails to users
      
      params[:mail_friends][:email].each do |email|
        UserNotification.notify_user(email[1], cookies["last_poll"]).deliver
      end

      # set cookie so we know this form was filled out
      cookies["mailed-" + params[:mail_friends][:poll_code]] = true
      render "home/index"
    
    end 
    
  end
  
end