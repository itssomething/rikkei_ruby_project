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
        redirect_to admin_path and return
      else
        flash.keep[:success] = "Login successfully"
        redirect_to user_home_path and return
      end
    else
      flash[:danger] = "Failed to log in "
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = "Logout successfully"
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
