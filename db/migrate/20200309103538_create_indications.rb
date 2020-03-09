class CreateIndications < ActiveRecord::Migration[5.2]
  def change
    create_table :indications do |t|
      t.string :name
      t.references :presentation, foreign_key: true

      t.timestamps
    end
  end
end
