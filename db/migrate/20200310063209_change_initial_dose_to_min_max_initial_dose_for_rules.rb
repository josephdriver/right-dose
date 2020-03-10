class ChangeInitialDoseToMinMaxInitialDoseForRules < ActiveRecord::Migration[5.2]
  def change
    remove_column :rules, :initial_dose
    add_column :rules, :min_initial_dose, :integer
    add_column :rules, :max_initial_dose, :integer
  end
end
