class AddStatusFieldToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :status, :integer, default: 0
  end
end
