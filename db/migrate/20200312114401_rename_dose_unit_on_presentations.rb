class RenameDoseUnitOnPresentations < ActiveRecord::Migration[5.2]
  def change
    rename_column :presentations, :dose_unit, :drug_unit
  end
end
