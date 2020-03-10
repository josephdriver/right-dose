class AddRulesToCaseDrugs < ActiveRecord::Migration[5.2]
  def change
    add_reference :case_drugs, :rule, foreign_key: true
    remove_reference :case_drugs, :drug, index: true, foreign_key: true
  end
end
