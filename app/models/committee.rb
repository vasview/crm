class Committee < ApplicationRecord
  has_many :interactions, as: :classifiable
  has_many :representatives, through: :committees_representatives
end
