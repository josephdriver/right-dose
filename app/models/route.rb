class Route < ApplicationRecord
  ACRONYMS = ['IV', 'IMI', 'PO', 'IO']
  has_many :rules
  validates :acronym, inclusion: { in: ACRONYMS}
  include AlgoliaSearch

  algoliasearch do
    attributes :name, :acronym
    searchableAttributes ['name', 'acronym']
  end
end
