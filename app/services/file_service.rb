class FileService
  attr_reader :exam, :exam_file

  def initialize exam_file, params
    @exam_file = exam_file
    @params = params
  end

  def read_file
    Roo::Spreadsheet.open params[:file]
  end

  def create_exam_from_file
    sheet = read_file.sheet(0)

    ActiveRecord::Base.transaction(requires_new: true) do
      @exam = Exam.new name: params[:name], time: params[:time],
        number_of_questions: params[:number_of_questions],
        category_id: params[:category_id]
      row_count = 2
      question = @exam.questions.new(row: 2)

      # read each row
      while row_count <= sheet.last_row do
        if sheet.row(row_count)[0].present? && row_count > 2
          if question.valid?
            question.save
          else
            question.errors.messages.each do |key, value|
              value.each do |v|
                @exam_file.errors.add("row #{question.row}".to_sym, "Question #{key} #{v}")
              end
            end
          end
          question = @exam.questions.new
          question.row = row_count
          question.name = sheet.row(row_count)[0]
          create_answer
        else
          create_answer
        end
        row_count += 1
      end
    end
  end

  private

  attr_reader :params

  def create_answer
    @answer = question.answers.new
    @answer.content = sheet.row(row_count)[1]
    @answer.is_correct = (sheet.row(row_count)[2].present? && sheet.row(row_count)[2].downcase == "true")
  end
end
