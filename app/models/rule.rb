class Rule < ApplicationRecord
  attr_accessor :presentation_id

  PATIENT_TYPES = ['Adult', 'Pediatric', '']
  CALC_TYPES = ['Age based', 'Weight based', '']
  DOSE_UNITS = ['mg', 'mcg', 'ml', 'g', '']
  belongs_to :paramedic_type, optional: true
  belongs_to :route, optional: true
  belongs_to :indication
  has_one :presentation, through: :indication
  has_one :drug, through: :presentation
  belongs_to :rules
  has_one :organization, through: :paramedic_type
  validates :patient_type, inclusion: { in: PATIENT_TYPES }
  validates :calc_type, inclusion: { in: CALC_TYPES }
  validates :dose_unit, inclusion: { in: DOSE_UNITS }, presence: true
  validates :max_initial_dose, presence: true
  validates :max_single_dose, presence: true
  validates :indication, presence: true
  validates :drug, presence: true
  validates :presentation, presence: true
  validates :route, presence: true

  include AlgoliaSearch

  algoliasearch do
    attributes :min_age, :max_age, :repeat_dose, :min_interval, :max_interval, :min_weight, :max_weight, :calc_type, :paramedic_type_id, :route_id, :indication_id, :interval_unit, :max_initial_dose, :min_initial_dose, :max_single_dose, :max_total_dose
    searchableAttributes ['min_age', 'max_age', 'repeat_dose', 'min_interval', 'max_interval', 'min_weight', 'max_weight', 'calc_type', 'paramedic_type_id', 'route_id', 'indication_id', 'interval_unit', 'max_initial_dose', 'min_initial_dose', 'max_single_dose', 'max_total_dose']
  end

  def check_min_age_adult
    if self.patient_type == "Adult" && self.min_age < self.organization.pediatric_cutoff
      errors.add(:patient_type, "Minimum age for adult must be greate than cutoff")
    end
  end
end
