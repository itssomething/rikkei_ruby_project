class ExamsController < ApplicationController
  def new
    @exam = Exam.new category_id: category_param
    @category = Category.find_by id: category_param
    @questions = @exam.questions.build
    @answers = @questions.answers.build
  end

  def create
    @exam = Exam.new exam_params
  end

  def show
    @exam = Exam.find_by id: params[:id]
    @questions = @exam.questions.includes(:answers)
  end


  private

  def category_param
    params[:category_id]
  end

  def exam_params
    params.require(:exam).permit(:name, questions_attributes: [:name, :_destroy])
          .merge(category_id: params[:category_id])
  end
end
