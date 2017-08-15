class JobPosition < ApplicationRecord
  has_many :representatives
  has_many :users
end
