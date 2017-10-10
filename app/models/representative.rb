class Representative < ApplicationRecord
  belongs_to :company
  belongs_to :job_position

  has_many :executives, inverse_of: :reprsentative
  has_many :committee_representatives, dependent: :destroy
  has_many :committees, through: :committee_representatives

  accepts_nested_attributes_for :committee_representatives, allow_destroy: true

  def self.per_page 
    7
  end
end
