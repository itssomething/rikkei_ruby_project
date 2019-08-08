class TestAnswersController < ApplicationController
  def update
    # return unless params[:answers].present?

    @test_answer = TestAnswer.find_by test_id: params[:test_id],
      question_id: params[:question_id]

    return if @test_answer.blank?
    @test_answer.update_attributes answer: processed_answer
  end

  private

  def processed_answer
    if params_answers_class == Array
      params_answers.map(&:to_i).to_s.delete('[]"')
    elsif params_answers_class == String
      params_answers.to_s.delete('[]"')
    elsif params_answers.blank?
      ""
    end
  end

  def params_answers
    params[:answers]
  end

  def params_answers_class
    params_answers.class
  end
end
