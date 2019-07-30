class Answer < ApplicationRecord
  belongs_to :question

  def is_correct?
    is_correct
  end
end
