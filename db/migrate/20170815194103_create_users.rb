class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :work_phone
      t.string :mobile_phone
      t.references :job_position, foreign_key: true
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
