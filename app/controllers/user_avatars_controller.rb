class UserAvatarsController < ApplicationController
  def create
    @user = User.find_by email: params[:email]

    @user.avatar = params[:picture]
    @user.save
  end

  private

  def avatar_param

  end
end
