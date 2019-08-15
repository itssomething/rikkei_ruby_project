class CategoriesController < ApplicationController
  before_action :check_role
  
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find_by id: params[:id]
    @exams = @category.exams
  end
end
