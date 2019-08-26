class ExamFile
  include ActiveModel::Model
  include FileConcern

  attr_accessor :name, :number_of_questions, :time, :file, :category_id, :row

  validates :name, :number_of_questions, :time, :file, presence: true
  validate :file_extension
  validate :file_template

  # has_one_attached :file

  HEADER = %i(question answer correct).freeze

  private

  def file_extension
    return if valid_exam_extension.include? file.content_type.split("/").last
    errors.add(:file_extension, "is invalid")
  end

  def file_template
    file = Roo::Spreadsheet.open self.file
    return if file.sheet(0).row(1).map(&:strip) == HEADER.map(&:to_s).map(&:humanize)
    errors.add(:file, "format does not match, please use template")
  end

  # def correct_column_mismatch
  #   file = Roo::Spreadsheet.open self.file

  #   column = file.sheet(0).column(1)
  #   return if (column.map(&:downcase) & ["true", "false"]).any?
  #   errors.add(:)
  # end
end
