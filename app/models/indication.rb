class Indication < ApplicationRecord
  belongs_to :drug, optional: true
  has_many :rules
end
