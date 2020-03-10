class ParamedicType < ApplicationRecord
  belongs_to :organization
  has_many :paramedics
end
