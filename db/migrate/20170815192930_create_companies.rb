class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.references :industry, foreign_key: true
      t.references :city, foreign_key: true
      t.string :address
      t.string :work_phone
      t.string :mobile_phone
      t.string :email
      t.date :birthdate
      t.text :notes

      t.timestamps
    end
  end
end
