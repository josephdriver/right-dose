class Indication < ApplicationRecord
  belongs_to :drug, optional: true
  has_many :rules, dependent: :destroy
  belongs_to :presentation
  has_one :drug, through: :presentation
end
