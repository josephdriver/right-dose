class Drug < ApplicationRecord
  include AlgoliaSearch
  belongs_to :organization
  has_many :presentations
  has_many :indications, through: :presentations
  has_many :rules, through: :indications

  validates :name, presence: true, uniqueness: true

  algoliasearch do
    # Use all default configuration
    attribute :name
  end
end
