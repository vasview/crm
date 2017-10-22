class Interaction < ApplicationRecord
  include Filterable

  scope :company, -> (company_id) { where company_id: company_id }
  scope :period, -> (period) { where start_date: period.first..period.last }
  scope :service, -> (service_id) { where service_id: service_id }
  scope :user, -> (user_id) { where user_id: user_id }

  belongs_to :company, optional: true
  belongs_to :representative, optional: true
  belongs_to :service
  belongs_to :user
  belongs_to :category, optional: true
  belongs_to :committee, optional: true

  has_many :interaction_results

  self.per_page = 20

end
