class TestsController < ApplicationController
  include UserConcern

  before_action :check_user_logged_in

  def new
    @exams = Exam.all
  end

  def create
    @test = Test.create! exam_id: params[:exam_id], user_id: current_user.id,
      time_start: Time.now
    questions_list_ids = Exam.find_by(id: 3).question_ids.sample(20)
    questions_list_ids.each do |question_id|
      @test_answers = @test.test_answers.create! question_id: question_id,
        test_id: @test.id
    end
    redirect_to @test
  end

  def show
    @test = Test.find_by(id: params[:id])
    @test_answers = @test.test_answers
    @questions = @test.questions.includes(:answers)
  end

  def edit
  end

  def update
    # k: question id, v: answer id
    byebug
    @test = Test.find_by id: params[:id]
    @test.assign_attributes status: "tested"
    score = 0
    answer_params.each do |k,v|
      update_answer_column @test.id, k, v
      score += 1 if check_correction? k, v
    end
    @test.update_attributes status: "tested", score: score
  end

  private

  def check_user_logged_in
    redirect_to new_session_path unless current_user.present?
  end

  def answer_params
    params.require(:question).permit!
  end

  def check_correction? k, v
    answer = Answer.find_by id: v
    return true if answer.is_correct? && answer.question_id == k
    false
  end

  def update_answer_column test_id, k, v
    test_answer = TestAnswer.find_by test_id: test_id
    test_answer.update_attributes answer: v.to_s,
      correct_answer: Answer.where(question_id: k, is_correct: true).first
  end
end
