class AddMembershipDateFieldsToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :entry_date, :date
    add_column :companies, :exit_date, :date
    add_column :companies, :exit_reason, :string
  end
end
