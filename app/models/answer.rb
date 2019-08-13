class Answer < ApplicationRecord
  # before_save :normalize_params

  belongs_to :question

  def is_correct?
    is_correct
  end

  def is_chosen? test_id, question_id
    test_answer = TestQuestion.find_by(test_id: test_id, question_id: question_id)
  end

  private

  def normalize_params
    self.assign_attributes is_correct: (self.is_correct == "false" ? false : true)
  end
end
