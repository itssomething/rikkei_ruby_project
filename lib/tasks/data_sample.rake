namespace :data_sample do
  task data: :environment do
    Rake::Task["user_sample:users"].invoke
    Rake::Task["category_sample:categories"].invoke
    Rake::Task["exam_sample:exams"].invoke
  end
end
