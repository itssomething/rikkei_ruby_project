class AddCategoryToExam < ActiveRecord::Migration[5.2]
  def change
    add_reference :exams, :category, foreign_key: true
  end
end
