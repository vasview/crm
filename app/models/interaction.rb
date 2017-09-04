class Interaction < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :representative, optional: true
  belongs_to :service
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :committee, optional: true
end
