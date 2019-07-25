class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :name
      t.boolean :is_multi

      t.timestamps
    end
  end
end
