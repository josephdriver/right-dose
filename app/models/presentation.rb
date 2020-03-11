class Presentation < ApplicationRecord
  DOSE_UNITS = ["", "g", "mg", "mcg"]
  VOLUME_UNITS = ["ml", "EpiPen"]
  belongs_to :drug
  has_many :indications, dependent: :destroy
  validates :dose_unit, inclusion: { in: DOSE_UNITS}
  validates :volume_unit, inclusion: { in: VOLUME_UNITS}
end
