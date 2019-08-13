namespace :data_sample do
  task data: :environment do
    Rake::Task["user_sample:users"].invoke
    Rake::Task["category_sample:categories"].invoke
    Rake::Task["exam_sample:exams"].invoke
    Rake::Task["test_chart_sample:test_chart"].invoke
    Rake::Task["test_chart_data:test_chart"].invoke
    Rake::Task["user_chart_sample:user_chart"].invoke
  end
end
