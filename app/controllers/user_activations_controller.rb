class UserActivationsController < ApplicationController
  before_action :find_user
  before_action :validate_token

  def edit
    @user.update_attributes activated: true

    flash[:success] = "Acount activation successfully"
    login @user
  end

  private

  def find_user
    @user = User.find_by email: params[:email]

    return if @user.present?
    flash[:danger] = "User not exist"
    redirect_to root_path and return
  end

  def validate_token
    return if @user.activation_token == params[:id]
    flash[:danger] = "Activation token mismatch"
    redirect_to root_path and return
  end

  def login user
    session[:user_id] = @user.id
    redirect_to root_path and return
  end
end
