class Drug < ApplicationRecord
  belongs_to :organization
  has_many :presentations
  has_many :indications, through: :presentations
  has_many :rules, through: :indications

  validates :name, presence: true, uniqueness: true
end
