class AddStatusFieldToIndustries < ActiveRecord::Migration[5.1]
  def change
    add_column :industries, :status, :integer, default: 0
  end
end
