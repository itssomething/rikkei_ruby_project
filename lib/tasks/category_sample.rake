namespace :category_sample do
  task categories: :environment do
    puts "Sample categories data"
    5.times do |n|
      Category.create!(name: Faker::Team.state)
      puts "!"
    end
  end
end
