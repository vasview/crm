class Industry < ApplicationRecord
  has_many :companies

  enum status: [:active, :archived]
end
