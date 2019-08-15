class ExamsController < ApplicationController
  before_action :find_exam, only: %w(show edit update destroy)
  before_action :check_role, only: %w(new create edit update destroy)

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
    @exam = Exam.new exam_params

    if exam.save
      redirect_to category_exam_path(exam.category, exam) and return
    else
      render :new and return
    end
  end

  def show
    @questions = exam.questions.includes(:answers)
  end

  def edit
    @category = Category.find_by id: params[:category_id]
    @questions = exam.questions

  end

  def update
    if exam.update_attributes exam_params
      flash[:success] = "Exam updated"
      redirect_to category_exam_path(exam.category, exam) and return
    else
      render :edit
    end
  end

  def destroy
    if exam.destroy
      flash[:success] = "Exam deleted"
      respond_to do |format|
        format.js
      end
    end
  end

  private

  attr_reader :exam

  def find_exam
    @exam = Exam.find_by id: params[:id]

    return if @exam.present?
    flash[:danger] = "Exam not found"
    redirect_to root_path
  end

  def category_param
    params[:category_id]
  end

  def exam_params
    params.require(:exam).permit(
      :name, :number_of_questions, :time,
      :questions_attributes => [
        :id, :name, :_destroy, :answers_attributes => [
          :id, :content, :is_correct, :_destroy
        ]
      ]).merge(category_id: params[:category_id])
  end
end
