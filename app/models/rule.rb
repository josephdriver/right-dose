class Rule < ApplicationRecord
  belongs_to :paramedic_type
  belongs_to :route
  belongs_to :indication
  has_one :organization, through: :paramedic_type
end
