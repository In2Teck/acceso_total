#encoding: utf-8
class UserMailer < ActionMailer::Base
  default :from => "tradicional.cuervo@gmail.com"
  
  def registration_confirmation(email, nombre)
    @user = current_user
    mail(:to => "#{email}", :subject => "¿Ya estás participando en acceso total tradicional?")
  end
end
