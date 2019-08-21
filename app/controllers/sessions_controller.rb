class SessionsController < ApplicationController
  # include UserConcern
  layout "session"

  before_action :find_user, only: %i(create)
  before_action :check_activation, only: %i(create)

  def new
  end

  def create
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
    redirect_to new_session_path and return
  end

  private

  attr_accessor :user

  def find_user
    @user = User.find_by email: email_param

    return if @user.present?
    flash[:danger] = "Email does not exist"
    render :new
  end

  def method_name
    return if @user.activated?
    flash[:danger] = "Account not activated, please check your email"
    render :new
  end

  def email_param
    params[:email]
  end

  def password_param
    params[:password]
  end

  def check_activation
    return if @user.activated?
    flash[:danger] = "Please activate your account. #{view_context.link_to('Resend email', resend_email_path(email: @user.email), method: :post)}".html_safe
    render :new
  end
end
