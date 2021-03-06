class Test < ApplicationRecord
  include TestConcern

  before_create :set_status
  after_create :create_submit_job

  belongs_to :exam
  belongs_to :user

  has_many :test_answers
  has_many :questions, through: :test_answers

  enum status: {not_tested: 0, tested: 1}

  scope :score_leaderboard, -> do
    joins(:user).order(score: :desc).includes(:user).includes(:exam)
  end

  scope :view_by_status, ->(status) do
    return if status.blank?

    where(status: status)
  end

  def remain_time
    self.time_start + self.exam.time * 60 - Time.zone.now
  end

  def remain_mins
    min = (self.remain_time/60).floor
    if min.to_s.length == 1
      min = "0" + min.to_s
    end
    min
  end

  def remain_secs
    sec = self.remain_time.modulo(60).floor
    if sec.to_s.length == 1
      sec = "0" + sec.to_s
    end
    sec
  end

  def time_remain_positive?
    remain_time > 0
  end

  def submit
    return if self.status == "tested"
    self.update_attributes status: "tested"
    score = 0
    test_answers = self.test_answers
    test_answers.each do |test_answer|
      score +=1 if test_answer.answer == test_answer.correct_answer
    end
    self.update_attributes score: score
  end

  private

  def set_status
    self.assign_attributes status: :not_tested
  end

  def create_submit_job
    self.delay(run_at: self.exam.time.minutes.from_now).submit
  end
end
