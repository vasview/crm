class CreateJobPositions < ActiveRecord::Migration[5.1]
  def change
    create_table :job_positions do |t|
      t.string :title

      t.timestamps
    end
  end
end
