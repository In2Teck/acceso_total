#encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "tradicional.cuervo@gmail.com"
  
  def registration_confirmation(email, current_user_email)
    @user = current_user_email
    mail(:to => "#{email}", :subject => "¿Ya estás participando en acceso total tradicional?")
  end
end
