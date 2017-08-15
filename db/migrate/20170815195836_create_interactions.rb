class CreateInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :interactions do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :company, foreign_key: true
      t.references :representative, foreign_key: true
      t.references :service, foreign_key: true
      t.references :user, foreign_key: true
      t.references :classifiable, polymorphic: true, index: true
      t.text :notes

      t.timestamps
    end
  end
end
