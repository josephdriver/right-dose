class ParamedicType < ApplicationRecord
  belongs_to :organization
  has_many :paramedics
  has_many :rules
  has_one_attached :photo

  include AlgoliaSearch

  algoliasearch do
    attributes :title, :acronym, :organization_id
    searchableAttributes ['title', 'acronym', 'organization_id']
  end
end
