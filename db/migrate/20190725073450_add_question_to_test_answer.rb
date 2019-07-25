class AddQuestionToTestAnswer < ActiveRecord::Migration[5.2]
  def change
    add_reference :test_answers, :question, foreign_key: true
  end
end
