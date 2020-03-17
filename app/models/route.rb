class Route < ApplicationRecord
  ACRONYMS = ['IV', 'IM', 'PO', 'IO', 'NEB', 'IN']
  has_many :rules
  validates :acronym, inclusion: { in: ACRONYMS}
  include AlgoliaSearch

  algoliasearch do
    attributes :name, :acronym
    searchableAttributes ['name', 'acronym']
  end
end
