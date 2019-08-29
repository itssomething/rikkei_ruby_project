namespace :exam_sample do
  task exams: :environment do
    puts "Sample exams data"
    10.times do |n|
      @exam = Exam.new(name: Faker::Educator.course_name, category: Category.all.sample(1).first, time: 20,
        number_of_questions: 20)
      40.times do |m|
        puts "question #{m}"
        multi = [true, false].sample
        ActiveRecord::Base.transaction do
          @question = @exam.questions.new(name: Faker::Lorem.sentence(word_count: 18), is_multi: multi, exam_id: @exam.id)
          if multi == true
            2.times do |k|
              @answer = @question.answers.new(content: Faker::Lorem.sentence(word_count: 9),
                is_correct: true, question_id: @question.id)
            end

            2.times do |k|
              @answer = @question.answers.new(content: Faker::Lorem.sentence(word_count: 9),
                is_correct: true, question_id: @question.id)
            end
          else
            @answer = @question.answers.new(content: Faker::Lorem.sentence(word_count: 9),
              is_correct: true, question_id: @question.id)
            3.times do |k|
              @answer = @question.answers.new(content: Faker::Lorem.sentence(word_count: 9),
                is_correct: false, question_id: @question.id)
            end
          end
        end
      end
      @exam.save!
    end
  end
end
