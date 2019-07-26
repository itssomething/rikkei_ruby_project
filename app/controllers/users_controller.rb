class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      flash[:success] = "User created"
      redirect_to users_path
    else
      flash[:danger] = "Failed"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
