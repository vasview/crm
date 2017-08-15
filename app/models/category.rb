class Category < ApplicationRecord
  has_many :interactions, as: :classifiable
  has_many :companies
end
