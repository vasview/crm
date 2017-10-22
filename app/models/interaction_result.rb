class InteractionResult < ApplicationRecord
  scope :period, -> (period) { where created_at: period.first..period.last }

  belongs_to :company
  belongs_to :interaction
end
