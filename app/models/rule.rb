class Rule < ApplicationRecord
  attr_accessor :presentation_id

  PATIENT_TYPES = ['Adult', 'Pediatric']
  CALC_TYPES = ['Age based', 'Weight based']
  DOSE_UNITS = ['mg', 'mcg', 'ml', 'g']
  belongs_to :paramedic_type, optional: true
  belongs_to :route, optional: true
  belongs_to :indication
  has_one :presentation, through: :indication
  has_one :drug, through: :presentation
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

  validate :check_min_age_has_max_age
  validate :check_adult_min_age_valid
  validate :pediatric_age_presence
  validate :pediatric_age_check

  include AlgoliaSearch

  algoliasearch do
    attributes :min_age, :max_age, :repeat_dose, :min_interval, :max_interval, :min_weight, :max_weight, :calc_type, :paramedic_type_id, :route_id, :indication_id, :interval_unit, :max_initial_dose, :min_initial_dose, :max_single_dose, :max_total_dose
    searchableAttributes ['min_age', 'max_age', 'repeat_dose', 'min_interval', 'max_interval', 'min_weight', 'max_weight', 'calc_type', 'paramedic_type_id', 'route_id', 'indication_id', 'interval_unit', 'max_initial_dose', 'min_initial_dose', 'max_single_dose', 'max_total_dose']
  end

  def check_min_age_has_max_age
    if self.patient_type == 'Adult'
      if !self.min_age.nil? && self.max_age.nil?
        errors.add(:max_age, 'Must enter max age if min age present')
      end
    elsif self.patient_type == 'Pediatric'
      if self.max_age.nil?
        errors.add(:max_age, 'Must enter max age for pediatric rule')
      end
    end
  end

  def check_adult_min_age_valid
    if !self.min_age.nil?
      if self.patient_type == "Adult" && self.min_age < self.organization.pediatric_cutoff
        errors.add(:min_age, 'Must age must be greater than Pediatric Cutoff age')
      end
    end
  end

  def pediatric_age_presence
    if self.patient_type == 'Pediatric' && self.max_age.nil?
      errors.add(:max_age, 'Must enter max age for Pediatric patient')
    end
  end

  def pediatric_age_check
    if !self.max_age.nil?
      if self.max_age > self.organization.pediatric_cutoff && self.patient_type == 'Pediatric'
        errors.add(:max_age, 'Maximum age must be less than organization cutoff')
      end
    end
  end
end
