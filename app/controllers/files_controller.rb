class FilesController < ApplicationController
  def new
  end

  def upload_exam
    binding.pry

    file = Roo::Spreadsheet.open(params[:file])
    sheet = file.sheet(0)
    ActiveRecord::Base.transaction(requires_new: true) do
      @exam = Exam.create! name: sheet.row(1)[1], time: sheet.row(2)[1],
        number_of_questions: sheet.row(3)[1], category_id: params[:category_id]

      ((sheet.first_row + 1)..sheet.last_row).each do |row|
        if sheet.row(row)[0] == "question"
          ActiveRecord::Base.transaction do
            # create question and save instance
            question = Question.create! name: sheet.row(row)[1], exam: exam
            number_of_answers = sheet.row(row+1)[1]
            counter = 0
            while counter < number_of_answers.to_i do
              content = sheet.row(row+1+counter+1)[1]
              correct = sheet.row(row+1+counter+1)[2]
              Answer.create! content: content, is_correct: correct, question: question
              counter += 1
            end
          end
        end
      end
    end
    redirect_to category_exam_path(params[:category_id], @exam)
  end

  def download_exam_template
    send_file(
      "#{Rails.root}/public/exam_template.csv",
      filename: "exam_template.csv",
      type: "application/csv"
    )
  end

  private

  attr_reader :exam
end
