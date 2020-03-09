class CreateCases < ActiveRecord::Migration[5.2]
  def change
    create_table :cases do |t|
      t.integer :age
      t.integer :weight
      t.references :paramedic, foreign_key: true

      t.timestamps
    end
  end
end
