class Presentation < ApplicationRecord
  DRUG_UNITS = ["", "g", "mg", "mcg", "ml"]
  VOLUME_UNITS = ["ml", "EpiPen", "ml ViaFlex Bag"]
  belongs_to :drug
  has_many :indications, dependent: :destroy
  validates :drug_unit, inclusion: { in: DRUG_UNITS}
  validates :volume_unit, inclusion: { in: VOLUME_UNITS}

  include AlgoliaSearch

  algoliasearch do
    attributes :dose, :drug_unit, :volume, :volume_unit, :drug_id
    searchableAttributes ['dose', 'drug_unit', 'volume', 'volume_unit', 'drug_id']
  end
end
