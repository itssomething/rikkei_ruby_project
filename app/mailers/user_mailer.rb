class UserMailer < ApplicationMailer
  # default from: '123213@gmail.com'

  def reset_password user, token
    # binding.pry
    @user = user
    mail(to: user.email, subject: "Reset password instruction")
  end
end
