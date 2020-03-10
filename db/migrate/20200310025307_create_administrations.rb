class CreateAdministrations < ActiveRecord::Migration[5.2]
  def change
    create_table :administrations do |t|
      t.time :time
      t.integer :dose
      t.integer :cummulative_dose
      t.references :case_drug, foreign_key: true

      t.timestamps
    end
  end
end
