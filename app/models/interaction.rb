class Interaction < ApplicationRecord
  belongs_to :company
  belongs_to :representative
  belongs_to :service
  belongs_to :user
  belongs_to :classifiable, polymorphic: true
end
