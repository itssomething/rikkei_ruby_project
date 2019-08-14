namespace :exam_sample do
  task exams: :environment do
    puts "Sample exams data"
    15.times do |n|
      @exam = Exam.create!(name: Faker::Educator.course_name, category_id: rand(1..5), time: 20)
      10.times do |m|
        puts "question #{m}"
        multi = [true, false].sample
        ActiveRecord::Base.transaction do
          @question = @exam.questions.create!(name: Faker::Lorem.sentence(10), is_multi: multi, exam_id: @exam.id)
          if multi == true
            4.times do |k|
              @answer = @question.answers.create!(content: Faker::Lorem.sentence(3),
                is_correct: [true, false].sample, question_id: @question.id)
            end
          else
            @answer = @question.answers.create!(content: Faker::Lorem.sentence(3),
              is_correct: true, question_id: @question.id)
            3.times do |k|
              @answer = @question.answers.create!(content: Faker::Lorem.sentence(3),
                is_correct: false, question_id: @question.id)
            end
          end
        end
      end
    end
  end
end
