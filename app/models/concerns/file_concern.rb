module FileConcern extend ActiveSupport::Concern
  def valid_exam_extension
    %w(csv xls xlsx)
  end
end
