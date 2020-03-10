class Case < ApplicationRecord
  belongs_to :paramedic
  has_many :case_drugs
end
