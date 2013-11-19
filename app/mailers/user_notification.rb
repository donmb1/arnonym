class UserNotification < ActionMailer::Base
  default from: '"POLLIFY" <info@owli.de>'
  
  def notify_user(email, code)
    @code = code
    @poll = Poll.find_by_code(@code)
    mail(:to => email,
      :subject => "You've been invited to a POLLIFY poll.")
  end
  
  def notify_admin(email, code)
    @code = code
    @poll = Poll.find_by_code(@code)
    mail(:to => email,
      :subject => "Your new feedback-survey at POLLIFY was created.")
  end
  
  def notify_admin_of_comment(email, code)
    @code = code
    @poll = Poll.find_by_code(@code)
    mail(:to => email,
      :subject => "New comment and rating on your POLLIFY feedback-survey received.")
  end
end
