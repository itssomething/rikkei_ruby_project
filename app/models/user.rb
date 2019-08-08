class User < ApplicationRecord
  has_many :tests, dependent: :nullify

  has_secure_password

  enum role: {user: 0, admin: 1}

  scope :score_leaderboard, -> do
    #TODO tìm hiểu lại
    joins(:tests).includes(:tests).order(score: :desc)
  end

  # select count(t.id), users.name from tests t inner join users on t.user_id = users.id group by t.user_id;
  scope :tests_count, (lambda do
    joins(:tests).group(:user_id).count(:id)
  end)
end
