class MailsController < ApplicationController

  skip_before_filter :verify_authenticity_token 
  
  def mail_friends
    
  # mail shizzle here
  
  # set cookie so we know friends got emailed and can amend the front page form
  
  cookies["mailed-" + params[:mail_friends][:poll_code]] = true
  
  render "home/index"
    
  end
  
end