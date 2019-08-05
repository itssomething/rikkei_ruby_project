class ChangeTestTimeStartToDatetime < ActiveRecord::Migration[5.2]
  def change
    change_column :tests, :time_start, :datetime
  end
end
