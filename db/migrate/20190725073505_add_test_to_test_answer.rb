class AddTestToTestAnswer < ActiveRecord::Migration[5.2]
  def change
    add_reference :test_answers, :test, foreign_key: true
  end
end
