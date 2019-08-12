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
    # @test_info = Test.group("week(created_at").count(:id)
    # last_month = 1.months.ago.month
    # this_month = Time.now.month

    month_data = {}
    12.times do |n|
      month_data["#{n+1}"] = {}
      arr = []
      a = Test.where(created_at: start_of_month(n+1)..end_of_month(n+1), score: 0..10).count :id
      b = Test.where(created_at: start_of_month(n+1)..end_of_month(n+1), score: 11..15).count(:id)
      c = Test.where(created_at: start_of_month(n+1)..end_of_month(n+1), score: 15..20).count(:id)
      arr << a << b << c
      month_data["#{n+1}"] = arr.flatten
    end

    respond_to do |format|
      format.json {render json: month_data}
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
end
