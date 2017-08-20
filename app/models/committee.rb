class Committee < ApplicationRecord
  has_many :interactions, as: :classifiable
  has_many :committee_representatives
  has_many :representatives, through: :committee_representatives
end
