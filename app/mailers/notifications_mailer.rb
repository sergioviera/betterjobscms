class NotificationsMailer < ActionMailer::Base
  default :from => "codigoaustraltest@gmail.com"
  default :to => "codigoaustraltest@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "[BetterJobs.com] #{message.subject}")
  end
end
