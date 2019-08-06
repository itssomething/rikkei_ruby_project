class ExamsController < ApplicationController
  def index
    @exams = Exam.all
  end

  def new
    @exam = Exam.new category_id: category_param
    @category = Category.find_by id: category_param
    @questions = @exam.questions.build
    @answers = @questions.answers.build
  end

  def create
    byebug
    @exam = Exam.new exam_params
    @exam.save
  end

  def show
    @exam = Exam.find_by id: params[:id]
    @questions = @exam.questions.includes(:answers)
  end

  def destroy
    @exam = Exam.find_by params[:id]

    if @exam.destroy
      redirect_to exams_path
    end
  end

  private

  def category_param
    params[:category_id]
  end

  def exam_params
    params.require(:exam).permit(
      :name, :number_of_questions, :time,
      :questions_attributes => [
        :name, :_destroy, :answers_attributes=> [
          :content, :_destroy
        ]
      ]).merge(category_id: params[:category_id])
  end
end
