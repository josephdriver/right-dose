class CaseDrug < ApplicationRecord
  belongs_to :case
  belongs_to :drug
end
