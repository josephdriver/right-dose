class Case < ApplicationRecord
  belongs_to :paramedic
  has_many :case_drugs

  validates :age, presence: true, numericality: { greater_than: 0 }
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :paramedic_id, presence: true
end
