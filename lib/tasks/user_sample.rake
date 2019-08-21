namespace :user_sample do
  task users: :environment do
    puts "Sample users data"
    user = User.create!(name: "Admin", email: "admin@admin.com", password: "123456")
    user.admin!
    user.activate
    user = User.create!(name: "User", email: "user@user.com", password: "123456")
    user.user!
    user.activate 

    100.times do |n|
      name = Faker::Name.name
      user = User.create!(name: name, email: Faker::Internet.email(name: name),
        password: "123456", role: "user",
        created_at: rand(7.months.ago..Time.now))
      user.activate
      puts "User #{user.name} created"
    end
  end
end
