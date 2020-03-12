class Indication < ApplicationRecord
  belongs_to :drug, optional: true
  has_many :rules, dependent: :destroy
  belongs_to :presentation
  has_one :drug, through: :presentation

  include AlgoliaSearch

  algoliasearch do
    attributes :name, :presentation_id
    searchableAttributes ['name', 'presentation_id']
  end
end
