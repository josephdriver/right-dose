class AddIntervalUnitToRules < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :interval_unit, :integer
  end
end
