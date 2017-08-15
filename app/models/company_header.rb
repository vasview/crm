class CompanyHeader < ApplicationRecord
  belongs_to :company
  belongs_to :representative
end
