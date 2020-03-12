class Organization < ApplicationRecord
  WEIGHT_UNITS = ["kg", "lbs"]
  has_many :admin
  has_many :drugs, dependent: :destroy
  has_many :presentations, through: :drugs
  has_many :indications, through: :presentations
  has_many :rules, through: :indications
  has_many :paramedic_types, dependent: :destroy
  has_many :paramedics, through: :paramedic_types
  has_many :cases, through: :paramedics

  validates :weight_unit, inclusion: { in: WEIGHT_UNITS}
end
