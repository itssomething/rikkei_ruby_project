class Test < ApplicationRecord
  before_create :set_status

  belongs_to :exam
  belongs_to :user

  has_many :test_answers
  has_many :questions, through: :test_answers

  enum status: {not_tested: 0, tested: 1}

  scope :score_leaderboard, (lambda do
    joins(:user).order(score: :desc).includes(:user)
  end)

  private

  def set_status
    self.assign_attributes status: :not_tested
  end
end
