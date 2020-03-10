class Indication < ApplicationRecord
  belongs_to :drug
  has_many :rules
end
