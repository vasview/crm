class CreateRepresentatives < ActiveRecord::Migration[5.1]
  def change
    create_table :representatives do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :work_phone
      t.string :mobile_phone
      t.string :email
      t.references :company, foreign_key: true
      t.references :job_position, foreign_key: true
      t.date :birthdate
      t.text :notes
      t.boolean :company_header

      t.timestamps
    end
  end
end
