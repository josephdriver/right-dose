class Administration < ApplicationRecord
  belongs_to :case_drug

  include AlgoliaSearch

  algoliasearch do
    attributes :time, :dose, :cummulative_dose, :case_drug_id
    searchableAttributes ['time', 'dose', 'cummulative_dose', 'case_drug_id']
  end
end
