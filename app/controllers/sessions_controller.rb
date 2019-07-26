class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by email: email_param

    if user && user.authenticate(password_param)
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:danger] = "Failed to log in "
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

  private

  attr_accessor :user

  def email_param
    params[:email]
  end

  def password_param
    params[:password]
  end
end
