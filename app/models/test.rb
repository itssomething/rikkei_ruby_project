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

  scope :view_by_status, (lambda do |status|
    return if status.blank?
    
    where(status: status)
  end)

  def remain_time
    self.time_start + self.exam.time * 60 - Time.zone.now
  end

  def remain_mins
    min = (self.remain_time/60).round(half: :down)
    if min.to_s.length == 1
      min = "0" + min.to_s
    end
    min
  end

  def remain_secs
    sec = self.remain_time.modulo(60).round(half: :down)
    if sec.to_s.length == 1
      sec = "0" + sec.to_s
    end
    sec
  end

  def time_remain_positive?
    remain_time > 0
  end

  private

  def set_status
    self.assign_attributes status: :not_tested
  end
end
