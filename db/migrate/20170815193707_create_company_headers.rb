class CreateCompanyHeaders < ActiveRecord::Migration[5.1]
  def change
    create_table :company_headers do |t|
      t.references :company, foreign_key: true
      t.references :representative, foreign_key: true

      t.timestamps
    end
  end
end
