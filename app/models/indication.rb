class Indication < ApplicationRecord
  belongs_to :drug, optional: true
end
