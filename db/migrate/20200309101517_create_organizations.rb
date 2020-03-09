class CreateOrganizations < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :location
      t.integer :pediatric_cutoff
      t.integer :multiplier
      t.integer :addition_num
      t.integer :weight_6mth
      t.integer :weight_3mth
      t.string :weight_unit

      t.timestamps
    end
  end
end
