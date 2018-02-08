class Service < ApplicationRecord
	validates :name, presence: true
  validates :cost, presence: true, numericality: true
  validates :committee_cost, presence: true, numericality: true

	enum status: [:active, :archived]
end
