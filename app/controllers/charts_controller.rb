class ChartsController < ApplicationController
  def user_creation_info
    @user_creation_info = User.group("week(created_at)").count(:id)

    new_hash = {}
    @user_creation_info.map do |k, v|
      new_hash["#{Date.commercial(Time.now.year, k, 1).strftime("%d/%m/%Y")} - #{Date.commercial(Time.now.year, k, 4).strftime("%d/%m/%Y")}"] = v
    end

    @user_creation_info = new_hash
  end

  def tests_info
    respond_to do |format|
      format.json {render json: case params[:option].to_i
                                when 0
                                  year_data
                                when 1
                                  month_data
                                end}
    end
  end

  private

  # attr_reader :user_creation_info

  def start_of_month month
    Date.parse("01/#{month}/#{Time.now.year}")
  end

  def end_of_month month
    Date.parse("01/#{month}/#{Time.now.year}").end_of_month
  end

  def start_of_week week
    Time.now.beginning_of_month + (week - 1).weeks
  end

  def end_of_week week
    Time.now.beginning_of_month + (week - 1)
  end

  def start_days
    arr = [Time.now.beginning_of_month]

    while((arr.last + 1.weeks) < Time.now.end_of_month) do
      arr.push (arr.last + 1.weeks).beginning_of_week
    end
    arr
  end

  # current year data
  def year_data
    year_data = {}

    12.times do |n|
      year_data["#{n+1}"] = {}
      arr = []
      a = Test.where(created_at: start_of_month(n+1)..end_of_month(n+1), score: 0..10).count :id
      b = Test.where(created_at: start_of_month(n+1)..end_of_month(n+1), score: 11..15).count(:id)
      c = Test.where(created_at: start_of_month(n+1)..end_of_month(n+1), score: 15..20).count(:id)
      arr.push(a, b, c)
      year_data["#{n+1}"] = arr
    end
    year_data
  end

  # current month data
  def month_data
    return unless current_user.present? && current_user.admin?

    month_data = {}
    start_days.each do |n|
      arr = []
      arr.push(Test.where(created_at: n..n.end_of_week, score: 0..10).count(:id),
        Test.where(created_at: n..n.end_of_week, score: 11..15).count(:id),
        Test.where(created_at: n..n.end_of_week, score: 16..20).count(:id))
      month_data["#{n.strftime("%d/%m/%Y")} - #{n.end_of_week.strftime("%d/%m/%Y")}"] = arr
    end
    month_data
  end
end
