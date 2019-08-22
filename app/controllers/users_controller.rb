class UsersController < ApplicationController
  before_action :check_logged_in, only: %i(new)
  before_action :find_user, only: %i(show edit update)
  before_action :check_editable, only: :edit
  def new
    @user = User.new
    render :new, layout: "session"
  end

  def index
    @users = User.includes(:tests).page(params[:page]).per(13)
    @tests_count = User.tests_count

    respond_to do |format|
      format.html {}
      format.json{render json: @users}
    end
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.update_attributes activation_token: generate_token
      UserMailer.send_activation_email(@user, generate_token).deliver_now
      flash[:success] = "Please check your email"
      redirect_to root_path and return
    else
      flash[:danger] = "Failed"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = "User information updated"
      redirect_to user_path(@user)
    else
      flash[:danger] = "Failed to update"
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by id: params[:id]

    return if @user.present?
    flash[:danger] = "User not found"
    redirect_to root_path and return
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def generate_token
    SecureRandom.urlsafe_base64(nil, false)
  end

  def check_logged_in
    return unless current_user.present?
    redirect_to root_path and return
  end

  def check_editable
    return if current_user.admin? || @user == current_user
    flash[:danger ] = "You are not authorized"
    redirect_to root_path and return
  end
end
