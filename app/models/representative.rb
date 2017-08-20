class Representative < ApplicationRecord
  belongs_to :company
  belongs_to :job_position

  has_many :executives
  has_many :committee_representatives
  has_many :committees, through: :committee_representatives
end
