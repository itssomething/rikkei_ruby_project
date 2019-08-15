class TestAnswersController < ApplicationController
  def index
    @test_answers = TestAnswer.where(test_id: params[:test_id]).select(:answer, :question_id, :test_id)

    return if @test_answers.first.test.tested?

    respond_to do |format|
      format.json {render json: @test_answers}
    end
  end

  def update
    # return unless params[:answers].present?

    @test_answer = TestAnswer.find_by test_id: params[:test_id],
      question_id: params[:question_id]

    return if @test_answer.blank?
    @test_answer.update_attributes answer: processed_answer
  end

  private

  def processed_answer
    if params[:answers].class == Array
      params_answers.map(&:to_i).to_s.delete('[]"')
    elsif params[:answers].class == String
      params[:answers].to_s.delete('[]"')
    elsif params[:answers].blank?
      ""
    end
  end

  def params_answers
    params[:answers]
  end
end
