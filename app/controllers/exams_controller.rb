class ExamsController < ApplicationController
  def index
    @exams = Exam.all.includes(:category)
    @questions_count = Exam.questions_count
  end

  def new
    @exam = Exam.new category_id: params[:category_id]
    @category = Category.find_by id: params[:category_id]
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

  def edit
    @exam = Exam.find_by id: params[:id]
    @category = Category.find_by id: params[:category_id]
    @questions = @exam.questions

  end

  def update
    @exam = Exam.find_by id: params[:id]
    redirect_to @exam
  end

  def destroy
    @exam = Exam.find_by id: params[:id]

    if @exam.destroy
      flash[:success] = "Exam deleted"
      respond_to do |format|
        format.js
      end
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
        :name, :_destroy, :answers_attributes => [
          :content, :is_correct, :_destroy
        ]
      ]).merge(category_id: params[:category_id])
  end
end
