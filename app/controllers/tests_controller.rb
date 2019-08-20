class TestsController < ApplicationController
  include UserConcern

  before_action :check_user_logged_in
  before_action :find_test, only: %w(show update)

  def index
    if current_user.admin?
      @tests = Test.all.includes(:user, :exam).page(params[:page]).per(10).order(created_at: :desc)
    else
      @tests = current_user.tests.includes(:user, :exam).view_by_status(param_status).page(params[:page]).per(10).order(created_at: :desc)
    end
  end

  def new
    @exams = Exam.all
  end

  def create
    @test = Test.create! exam_id: params[:exam_id], user_id: current_user.id,
      time_start: Time.zone.now
    # TODO: add number of question in exam (question bank)
    questions_list_ids = Exam.find_by(id: params[:exam_id]).question_ids.sample(@test.exam.number_of_questions)

    questions_list_ids.each do |question_id|
      @test_answers = @test.test_answers.create!( question_id: question_id,
                                                  test_id: @test.id)
    end
    redirect_to @test
  end

  def show
    @test_answers = @test.test_answers.includes(:question)
    @questions = @test.questions.includes(:answers)
  end

  def edit
  end

  def update
    # k: question id, v: answer id

    @test.assign_attributes status: "tested"
    score = 0

    # if answer_params.
    answer_params.each do |key, value|
      update_answer_column @test.id, key, value.to_s.delete("[] ")
      score += 1 if check_correction? key, value
    end
    @test.update_attributes status: "tested", score: score
    redirect_to @test
  end

  private

  attr_reader :test

  def find_test
    if current_user.admin?
      @test = Test.find_by id: params[:id]
    else
      @test = current_user.tests.find_by id: params[:id]
    end

    return unless @test.blank?
    flash[:danger] = "Test not exist"
    redirect_to root_path
  end

  def check_user_logged_in
    redirect_to new_session_path unless current_user.present?
  end

  def answer_params
    if params[:question].present?
      params.require(:question).permit!
    else
      {}
    end
  end

  def check_correction? k, v
    correct = Question.find_by(id: k).correct_answers_ids
    v.map(&:to_i).sort == correct.sort
  end

  def update_answer_column test_id, k, v
    test_answer = TestAnswer.find_by test_id: test_id, question_id: k
    test_answer.update_attributes answer: v.to_s.delete('" ')
  end

  def param_status
    params[:status]
  end
end
