class UserMailer < ActionMailer::Base
  default :from => "tradicional.cuervo@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Prueba mail")
  end
end
