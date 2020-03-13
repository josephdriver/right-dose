class Drug < ApplicationRecord

   attr_accessor :routes


  include AlgoliaSearch
  belongs_to :organization
  has_many :presentations, dependent: :destroy
  has_many :indications, through: :presentations
  has_many :rules, through: :indications

  validates :name, presence: true, uniqueness: true

  include AlgoliaSearch

  algoliasearch do
    attributes :name
    searchableAttributes ['name']
  end
end
