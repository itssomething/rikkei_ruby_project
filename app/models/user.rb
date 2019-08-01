class User < ApplicationRecord
  has_many :tests, dependent: :nullify

  has_secure_password

  enum role: {user: 0, admin: 1}

  scope :score_leaderboard, (lambda do
    joins(:tests).order(score: :desc).includes(:tests)
  end)
end
