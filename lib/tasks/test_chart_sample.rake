namespace :test_chart_sample do
  task test_chart: :environment do
    puts "Sample test chart data"

    100.times do |n|
      @test = Test.create! time_start: rand(30.days.ago..Time.now),
        score: rand(0..20), user_id: User.all.sample(1).first.id,
        exam_id: Exam.all.sample(1).first.id,
        created_at: rand(30.days.ago..Time.now)
      @test.tested!
      puts "created"
    end
  end

  task test_chart_data: :environment do
    200.times do |n|
      time_start = rand(8.months.ago..Time.now)
      @test = Test.create! time_start: time_start,
        score: rand(0..20), user_id: User.all.sample(1).first.id,
        exam_id: Exam.all.sample(1).first.id,
        created_at: time_start
      @test.tested!
      puts "created"
    end
  end
end
