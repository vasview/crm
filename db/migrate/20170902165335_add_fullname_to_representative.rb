class AddFullnameToRepresentative < ActiveRecord::Migration[5.1]
  def change
    add_column :representatives, :fullname, :string
  end
end
