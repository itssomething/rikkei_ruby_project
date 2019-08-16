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
                                when 3
                                  custom_data
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

  def custom_data
    return unless current_user.present? && current_user.admin?

    start_date = params[:start].to_date
    end_date = params[:end].to_date
    data = {}
    number_of_days = end_date - start_date
    # binding.pry
    if params[:step_type] == "day"
      counter = 0
      while(counter < number_of_days) do
        day = start_date + counter
        data["#{day}"] = nil
        arr = []
        # binding.pry
        arr.push(Test.where(created_at: day.beginning_of_day..day.end_of_day, score: 0..10).count(:id),
          Test.where(created_at: day.beginning_of_day..day.end_of_day, score: 11..15).count(:id),
          Test.where(created_at: day.beginning_of_day..day.end_of_day, score: 16..20).count(:id))
        data["#{day}"] = arr
        counter+=1
      end
    elsif params[:step_type] == "week"
      counter = 0
      next_date = start_date
      while next_date < end_date do
        if next_date == start_date
          week_start = start_date
          week_end = start_date.end_of_week
          arr = []
          arr.push(Test.where(created_at: week_start..week_end, score: 0..10).count(:id),
            Test.where(created_at: week_start..week_end, score: 11..15).count(:id),
            Test.where(created_at: week_start..week_end, score: 16..20).count(:id))
          data["#{week_start.strftime("%d/%m/%Y")} - #{week_end.strftime("%d/%m/%Y")}"] = arr
        else
          week_start = next_date.beginning_of_week
          week_end = next_date.end_of_week
          arr = []
          arr.push(Test.where(created_at: week_start..week_end, score: 0..10).count(:id),
            Test.where(created_at: week_start..week_end, score: 11..15).count(:id),
            Test.where(created_at: week_start..week_end, score: 16..20).count(:id))
          data["#{week_start.strftime("%d/%m/%Y")} - #{week_end.strftime("%d/%m/%Y")}"] = arr
        end
        next_date = next_date + 7
      end
    end
    data
  end
end
