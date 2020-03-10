class AddMaxTotalDoseToRules < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :max_total_dose, :value
  end
end
