class CaseDrug < ApplicationRecord
  belongs_to :case
  belongs_to :rules
  has_one :indication, through: :rule
  has_one :presentation, through: :indication
  has_one :drug, through: :presentation
end
