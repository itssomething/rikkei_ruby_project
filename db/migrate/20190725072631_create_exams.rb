class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.string :name
      t.integer :time
      t.integer :number_of_questions

      t.timestamps
    end
  end
end
