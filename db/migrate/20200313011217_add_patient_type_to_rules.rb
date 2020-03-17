class AddPatientTypeToRules < ActiveRecord::Migration[5.2]
  def change
    add_column :rules, :patient_type, :string
  end
end
