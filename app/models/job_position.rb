class JobPosition < ApplicationRecord
  has_many :representatives
  has_many :users

  enum status: [:active, :archived]
end
