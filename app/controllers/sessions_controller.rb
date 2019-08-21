class SessionsController < ApplicationController
  # include UserConcern
  layout "session"

  def new
  end

  def create
    @user = User.find_by email: email_param

    if user && user.authenticate(password_param)
      session[:user_id] = user.id

      if current_user.admin?
        flash[:success] = "Login successfully"
        redirect_to admin_path and return
      else
        flash[:success] = "Login successfully"
        redirect_to user_home_path and return
      end
    else
      flash.now[:danger] = "Failed to log in "
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logout successfully"
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

  def check_activation
    return if @user.activated?
    flash[:danger] = "Please check activate your account"
    render :new
  end
end
