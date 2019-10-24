class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    mail to: user.email, subject: "Witamy na naszej stronie"
  end
  
end
