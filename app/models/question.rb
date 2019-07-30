class Question < ApplicationRecord
  belongs_to :exam

  has_many :answers, dependent: :nullify
  has_many :test_answers
  has_many :tests, through: :test_answers

  accepts_nested_attributes_for :answers, allow_destroy: true,
    reject_if: proc{|attributes| attributes["content"].blank?}

  # enum is_multi: [false: 0, true: 1]

  def is_multi?
    is_multi
  end

  def correct_answers_ids
    self.answers.where(is_correct: true).pluck :id
  end
end
