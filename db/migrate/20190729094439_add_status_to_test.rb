class AddStatusToTest < ActiveRecord::Migration[5.2]
  def change
    add_column :tests, :status, :integer
  end
end
