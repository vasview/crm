class Category < ApplicationRecord
  has_many :interactions
  has_many :companies
end
