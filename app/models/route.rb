class Route < ApplicationRecord
  has_many :rules

  include AlgoliaSearch

  algoliasearch do
    attributes :name, :acronym
    searchableAttributes ['name', 'acronym']
  end
end
