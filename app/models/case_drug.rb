class CaseDrug < ApplicationRecord
  belongs_to :case
  belongs_to :rules
  has_one :indication, through: :rule
  has_one :presentation, through: :indication
  has_one :drug, through: :presentation

  validates :case_id, presence: true
  validates :drug_id, presence: true
end
