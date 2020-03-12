class ParamedicType < ApplicationRecord
  belongs_to :organization
  has_many :paramedics

  include AlgoliaSearch

  algoliasearch do
    attributes :title, :acronym, :organization_id
    searchableAttributes ['title', 'acronym', 'organization_id']
  end
end
