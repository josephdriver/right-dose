class AddDoseUnitToRules < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :dose_unit, :string
  end
end
