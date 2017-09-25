class Interaction < ApplicationRecord
  scope :company, -> (company_id) { where company_id: company_id }
  scope :period, -> (period) { where created_at: period.firt..period.last }

  belongs_to :company, optional: true
  belongs_to :representative, optional: true
  belongs_to :service
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :committee, optional: true

  has_many :interaction_results

end
