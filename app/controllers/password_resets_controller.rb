class PasswordResetsController < ApplicationController
  layout "session"

  before_action :find_user, only: %i(create edit update)
  before_action :check_token_expiration, only: %i(edit)
  before_action :validate_password_confirmation, only: %i(update)

  def new
  end

  def create
    @user.update_attributes reset_token: generate_token, reset_sent_at: Time.zone.now
    UserMailer.reset_password(@user, @user.reset_token).deliver_now

    flash[:success] = "Please check your email for reset instruction"
    redirect_to root_path and return
  end

  def edit
    return if @user.reset_token == params[:id]
    flash[:danger] = "Token mismatch"
    redirect_to root_path and return
  end

  def update
    if @user.update_attributes password: params[:password]
      flash[:success] = "Password reseted"
      redirect_to root_path and return
    else
      flash[:danger] = "Error"
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by email: params[:email]

    return if @user.present?
    flash[:danger] = "Email not exist"
    render :new
  end

  def generate_token
    SecureRandom.urlsafe_base64(nil, false)
  end

  def check_token_expiration
    return unless @user.reset_token_expired?
    flash[:danger] = "Token expired"
    redirect_to root_path and return
  end

  def validate_password_confirmation
    return if params[:password] == params[:password_confirmation]
    flash[:danger] = "Password does not match"
    render :edit
  end
end
