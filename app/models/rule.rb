class Rule < ApplicationRecord
  belongs_to :paramedic_type, optional: true
  belongs_to :route, optional: true
  belongs_to :indication
  has_one :organization, through: :paramedic_type

  include AlgoliaSearch

  algoliasearch do
    attributes :min_age, :max_age, :repeat_dose, :min_interval, :max_interval, :min_weight, :max_weight, :calc_type, :paramedic_type_id, :route_id, :indication_id, :interval_unit, :max_initial_dose, :min_initial_dose, :max_single_dose, :max_total_dose
    searchableAttributes ['min_age', 'max_age', 'repeat_dose', 'min_interval', 'max_interval', 'min_weight', 'max_weight', 'calc_type', 'paramedic_type_id', 'route_id', 'indication_id', 'interval_unit', 'max_initial_dose', 'min_initial_dose', 'max_single_dose', 'max_total_dose']
  end
end
