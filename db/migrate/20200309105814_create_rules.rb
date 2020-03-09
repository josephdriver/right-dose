class CreateRules < ActiveRecord::Migration[5.2]
  def change
    create_table :rules do |t|
      t.integer :min_age
      t.integer :max_age
      t.integer :initial_dose
      t.integer :repeat_dose
      t.integer :min_interval
      t.integer :max_interval
      t.integer :min_weight
      t.integer :max_weight
      t.string :calc_type
      t.references :paramedic_type, foreign_key: true
      t.references :route, foreign_key: true
      t.references :indication, foreign_key: true

      t.timestamps
    end
  end
end
