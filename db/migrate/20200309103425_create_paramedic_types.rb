class CreateParamedicTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :paramedic_types do |t|
      t.string :title
      t.string :acronym
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
