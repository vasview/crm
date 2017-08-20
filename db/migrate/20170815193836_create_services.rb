class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.float :cost
      t.float :committee_cost
      
      t.timestamps
    end
  end
end
