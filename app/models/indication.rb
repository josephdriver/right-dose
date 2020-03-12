class Indication < ApplicationRecord
  belongs_to :drug, optional: true
  has_many :rules, dependent: :destroy



  include AlgoliaSearch

  algoliasearch do
    attributes :name, :presentation_id
    searchableAttributes ['name', 'presentation_id']
  end
end
