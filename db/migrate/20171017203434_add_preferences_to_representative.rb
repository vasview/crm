class AddPreferencesToRepresentative < ActiveRecord::Migration[5.1]
  def change
    add_column :representatives, :preferences, :string
  end
end
