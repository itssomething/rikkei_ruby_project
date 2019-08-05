class TestAnswer < ApplicationRecord
  before_create :set_correct_answer
  before_create :set_empty_answer

  belongs_to :test
  belongs_to :question

  private

  def set_correct_answer
    self.correct_answer = Answer.where(question_id: self.question_id,
      is_correct: true).pluck(:id).to_s.delete('[] ')
  end

  def set_empty_answer
    self.answer = ""
  end
end
