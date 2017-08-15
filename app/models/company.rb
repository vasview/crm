class Company < ApplicationRecord
  belongs_to :category
  belongs_to :industry
  belongs_to :city
  has_many :representatives
end
