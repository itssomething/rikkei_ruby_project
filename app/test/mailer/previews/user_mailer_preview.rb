class UserMailerPreview < ActionMailer::Preview
  def reset_password
    user = OpenStruct.new(email: "demo@example.com", name: "John Doe")
    token = "123312321"
    UserMailer.reset_password(user, token)
  end
end
