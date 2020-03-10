class Rule < ApplicationRecord
  belongs_to :paramedic_type, optional: true
  belongs_to :route, optional: true
  belongs_to :indication
  has_one :organization, through: :paramedic_type
end
