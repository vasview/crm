class User < ApplicationRecord
  belongs_to :job_position
  belongs_to :role
end
