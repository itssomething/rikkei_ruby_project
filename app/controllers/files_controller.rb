class FilesController < ApplicationController
  include FileConcern

  before_action :check_role

  def new
    @exam_file = ExamFile.new
  end

  def upload_exam
    @exam_file = ExamFile.new name: params[:name], time: params[:time],
      number_of_questions: params[:number_of_questions],
      category_id: params[:category_id], file: params[:file]

    if !@exam_file.valid?
      raise ActiveRecord::RecordInvalid
    end

    file = Roo::Spreadsheet.open(params[:file])
    sheet = file.sheet(0)


    ActiveRecord::Base.transaction(requires_new: true) do
      @exam = Exam.new name: params[:name], time: params[:time],
        number_of_questions: params[:number_of_questions],
        category_id: params[:category_id]
      row_count = 2
      question = @exam.questions.new(row: 2)

      while row_count <= sheet.last_row do
        if sheet.row(row_count)[0].present? && row_count > 2
          if question.valid?
            question.save
          else
            question.errors.messages.each do |key, value|
              @exam_file.errors.add("row #{question.row}".to_sym, "question #{value[0]}")
            end
          end
          question = @exam.questions.new
          question.row = row_count
          question.name = sheet.row(row_count)[0]
          @answer = question.answers.new
          @answer.content = sheet.row(row_count)[1]
          @answer.is_correct = (sheet.row(row_count)[2].present? && sheet.row(row_count)[2].downcase == "true")

        else

          @answer = question.answers.new
          @answer.content = sheet.row(row_count)[1]
          @answer.is_correct = (sheet.row(row_count)[2].present? && sheet.row(row_count)[2].downcase == "true")

        end
        row_count += 1
      end
    end
    if @exam.save!
      redirect_to category_exam_path(params[:category_id], @exam) and return
    end
  rescue ActiveRecord::RecordInvalid
    exam_file
    render :new
  end

  def download_exam_template
    send_file(
      "#{Rails.root}/public/exam_template.csv",
      filename: "exam_template.csv",
      type: "application/csv"
    )
  end

  private

  attr_reader :exam_file, :exam

  def file_valid?
    valid_exam_extension.include? params[:file].content_type.split("/").last
  end
end
