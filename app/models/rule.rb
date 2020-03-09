class Rule < ApplicationRecord
  belongs_to :paramedic_type
  belongs_to :route
  belongs_to :indication
end
