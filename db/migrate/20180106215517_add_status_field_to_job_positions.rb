class AddStatusFieldToJobPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :job_positions, :status, :integer, default: 0
  end
end
