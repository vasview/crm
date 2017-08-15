class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.float :cost
<<<<<<< HEAD
=======
      t.float :committee_cost
>>>>>>> #1 Project's models were created. Need to verify their relationship.

      t.timestamps
    end
  end
end
