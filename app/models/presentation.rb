class Presentation < ApplicationRecord
  DOSE_UNITS = ["g", "mg", "mcg"]
  VOLUME_UNITS = ["L", "ml"]
  belongs_to :drug
  has_many :indications
  validates :dose_unit, inclusion: { in: DOSE_UNITS}
  validates :volume_units, inclusion: { in: VOLUME_UNITS}
end
