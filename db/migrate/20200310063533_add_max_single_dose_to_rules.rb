class AddMaxSingleDoseToRules < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :max_single_dose, :integer
  end
end
