class ApplicationController < ActionController::Base
  include ApplicationHelper

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def record_not_found
    redirect_to root_path and return
    flash[:danger] = "#{params[:controller].singularize.capitalize} not found"
  end
end
