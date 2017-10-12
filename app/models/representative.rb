class Representative < ApplicationRecord
  include Filterable
  
  belongs_to :company
  belongs_to :job_position

  has_many :executives, inverse_of: :reprsentative
  has_many :committee_representatives, dependent: :destroy
  has_many :committees, through: :committee_representatives

  accepts_nested_attributes_for :committee_representatives, allow_destroy: true

  scope :company, -> (company_id) { where company_id: company_id }
  scope :job, -> (job_position_id) { where job_position_id: job_position_id }
  scope :search, -> (name) { where("fullname ILIKE ?", "%#{name}%")}

  def self.per_page 
    7
  end
end
