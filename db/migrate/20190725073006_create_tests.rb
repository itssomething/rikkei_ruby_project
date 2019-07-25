class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.time :time_start
      t.integer :score

      t.timestamps
    end
  end
end
