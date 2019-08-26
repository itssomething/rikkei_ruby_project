class UserMailer < ApplicationMailer
  # default from: '123213@gmail.com'

  def reset_password user, token
    @user = user
    mail(to: user.email, subject: "Reset password instruction")
  end

  def send_activation_email user, token
    @user = user
    mail(to: user.email, subject: "Account activation")
  end
end
