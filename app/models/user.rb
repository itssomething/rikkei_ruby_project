class User < ApplicationRecord
  has_many :tests, dependent: :nullify

  has_secure_password

  enum role: {user: 0, admin: 1}

  scope :score_leaderboard, (lambda do
    joins(:tests).order(score: :desc).includes(:tests)
  end)

  scope :page_view, (lambda do |page_param|
    if page_param.present?
      page(page_param).per(13)
    else
      page(1).per(13)
    end
  end)

  # select count(t.id), users.name from tests t inner join users on t.user_id = users.id group by t.user_id;
  scope :tests_count, (lambda do
    joins(:tests).group(:user_id).count(:id)
  end)
end
