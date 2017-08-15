class Representative < ApplicationRecord
  belongs_to :company
  belongs_to :job_position
end
