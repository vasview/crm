class JobPosition < ApplicationRecord
  has_many :representatives
  has_many :users

  enum status: [:active, :archived]

  scope :status, -> (status) { where status: status }
end
