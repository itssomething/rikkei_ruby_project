class TestsController < ApplicationController
  include UserConcern

  before_action :check_user_logged_in

  def index
    if current_user.admin?
      @tests = Test.all
    else
      @tests = current_user.tests
    end
  end

  def new
    @exams = Exam.all
  end

  def create
    @test = Test.create! exam_id: params[:exam_id], user_id: current_user.id,
      time_start: Time.zone.now
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

    @test = Test.find_by id: params[:id]
    @test.assign_attributes status: "tested"
    score = 0
    answer_params.each do |key, value|
      update_answer_column @test.id, key, value.to_s.delete("[] ")
      score += 1 if check_correction? key, value
    end
    @test.update_attributes status: "tested", score: score
    redirect_to @test
  end

  private

  def check_user_logged_in
    redirect_to new_session_path unless current_user.present?
  end

  def answer_params
    params.require(:question).permit!
  end

  def check_correction? k, v
    correct = Question.find_by(id: k).correct_answers_ids
    v.map(&:to_i).sort == correct.sort
  end

  def update_answer_column test_id, k, v
    test_answer = TestAnswer.find_by test_id: test_id, question_id: k
    test_answer.update_attributes answer: v.to_s.delete('" ')
  end
end
