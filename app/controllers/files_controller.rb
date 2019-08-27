class FilesController < ApplicationController
  include FileConcern

  before_action :init_exam_file, only: :upload_exam
  before_action :init_file_service, only: :upload_exam
  before_action :check_role

  def new
    @exam_file = ExamFile.new
  end

  def upload_exam
    raise ActiveRecord::RecordInvalid unless @exam_file.valid?
    file_service.create_exam_from_file
    
    if file_service.exam.save!
      redirect_to category_exam_path(params[:category_id], @exam) and return
    end
  rescue ActiveRecord::RecordInvalid
    file_service.exam_file
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

  attr_reader :exam_file, :exam, :file_service

  def file_valid?
    valid_exam_extension.include? params[:file].content_type.split("/").last
  end

  def init_exam_file
    @exam_file = ExamFile.new name: params[:name], time: params[:time],
      number_of_questions: params[:number_of_questions],
      category_id: params[:category_id], file: params[:file]
  end

  def init_file_service
    @file_service = FileService.new exam_file, params
  end
end
