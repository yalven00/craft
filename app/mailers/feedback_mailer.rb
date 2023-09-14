class FeedbackMailer < ActionMailer::Base
  default from: "feedback@mycareerpal.co"

  def feedback(email, name, message)
    @email = email
    @name = name
    @message = message
    mail(to: 'feedback@craftlock.com')
  end
end
