class Representative < ApplicationRecord
  belongs_to :company
  belongs_to :job_position
<<<<<<< HEAD
=======
  has_many :committees, through: :committees_representatives
>>>>>>> #1 Project's models were created. Need to verify their relationship.
end
