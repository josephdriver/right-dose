class Presentation < ApplicationRecord
  DOSE_UNITS = ["", "g", "mg", "mcg", "ml"]
  VOLUME_UNITS = ["ml", "EpiPen", "ml ViaFlex Bag"]
  belongs_to :drug
  has_many :indications, dependent: :destroy
  validates :dose_unit, inclusion: { in: DOSE_UNITS}
  validates :volume_unit, inclusion: { in: VOLUME_UNITS}

  include AlgoliaSearch

  algoliasearch do
    attributes :dose, :dose_unit, :volume, :volume_unit, :drug_id
    searchableAttributes ['dose', 'dose_unit', 'volume', 'volume_unit', 'drug_id']
  end
end
