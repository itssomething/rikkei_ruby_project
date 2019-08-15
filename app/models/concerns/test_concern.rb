module TestConcern
  extend ActiveSupport::Concern

  def check_correction test_answer
    test_answer.answer == test_answer.correct_answer
  end
end
