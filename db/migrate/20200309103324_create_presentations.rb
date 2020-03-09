class CreatePresentations < ActiveRecord::Migration[5.2]
  def change
    create_table :presentations do |t|
      t.integer :dose
      t.string :dose_unit
      t.integer :volume
      t.string :volume_unit
      t.references :drug, foreign_key: true

      t.timestamps
    end
  end
end
