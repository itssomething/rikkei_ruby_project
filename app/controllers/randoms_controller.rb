class RandomsController < ApplicationController
  before_action :check_role

  def index
    @leaderboard = Test.score_leaderboard
    @categories = Category.all.includes(:exams)
  end

  private

  def check_role
    return if current_user.user?

    redirect_to admin_path
  end
end
