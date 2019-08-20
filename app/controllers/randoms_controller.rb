class RandomsController < ApplicationController
  before_action :check_user_presence
  before_action :check_role

  def index
    @leaderboards = Test.score_leaderboard.page(params[:page]).per(5)
    @categories = Category.all.includes(:exams)

    respond_to do |format|
      format.js {}
      format.html {}
    end
  end

  private

  def check_role
    return if current_user.user?

    redirect_to admin_path
  end

  def check_user_presence
    redirect_to new_session_path if current_user.blank?
  end
end
