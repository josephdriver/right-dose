class Presentation < ApplicationRecord
  belongs_to :drug
  has_many :indications

end
