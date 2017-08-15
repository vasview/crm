class CreateInteractionResults < ActiveRecord::Migration[5.1]
  def change
    create_table :interaction_results do |t|
      t.float :mark
      t.references :company, foreign_key: true
      t.references :interaction, foreign_key: true

      t.timestamps
    end
  end
end
