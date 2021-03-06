namespace :user_chart_sample do
  task user_chart: :environment do
    puts "Sample user chart data"

    50.times do |n|
      name = Faker::Name.name
      user = User.create!(name: name, email: Faker::Internet.email(name: name),
        password: "123456", role: "user",
        created_at: rand(7.months.ago..Time.now))
      user.activate
      puts "User #{user.name} created"
    end
  end
end
