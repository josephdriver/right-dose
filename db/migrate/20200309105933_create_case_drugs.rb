class CreateCaseDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :case_drugs do |t|
      t.references :case, foreign_key: true
      t.references :drug, foreign_key: true

      t.timestamps
    end
  end
end
