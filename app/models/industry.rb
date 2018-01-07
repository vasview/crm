class Industry < ApplicationRecord
  has_many :companies

  enum status: [:active, :archived]

  scope :status, -> (status) { where status: status }
end
