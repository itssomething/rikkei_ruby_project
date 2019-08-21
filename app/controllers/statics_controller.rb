class StaticsController < ApplicationController
  # include UserConcern

  before_action :check_logged_in
  before_action :check_role

  def index
  end

  private

  # def check_role
  #   return if current_user.admin?
  #   flash[:danger] = "You can not access this page"
  #   redirect_to "/"
  # end

  def check_logged_in
    return if current_user.present?

    redirect_to new_session_path and return
  end
end
