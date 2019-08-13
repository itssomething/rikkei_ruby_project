namespace :user_sample do
  task users: :environment do
    puts "Sample users data"
    User.create!(name: "Admin", email: "admin@admin.com", password: "123456", role: "admin")
    User.create!(name: "User", email: "user@user.com", password: "123456", role: "user")

    100.times do |n|
      name = Faker::Name.name
      user = User.create!(name: name, email: Faker::Internet.email(name: name) , password: "123456", role: "user")
      puts "User #{user.name} created"
    end
  end
end
