class CaseDrug < ApplicationRecord
  belongs_to :case
  belongs_to :rule

  accepts_nested_attributes_for :rule

  has_one :indication, through: :rule
  has_one :presentation, through: :indication
  has_one :drug, through: :presentation

  validates :case_id, presence: true

  include AlgoliaSearch

  algoliasearch do
    attributes :rule_id, :case_id
    searchableAttributes ['rule_id', 'case_id']
  end
end
