class UserNotification < ActionMailer::Base
  default from: "info@owli.de"
  
  def notify_user(email, code)
    @code = code
    mail(:to => email,
      :subject => "You've been invited to a poll.")
  end
  
  def notify_admin(email, code)
    @code = code
    mail(:to => email,
      :subject => "Your poll was created.")
  end
  
  def notify_admin_of_comment(email, code)
    @code = code
    mail(:to => email,
      :subject => "New comment and rating received.")
  end
end
