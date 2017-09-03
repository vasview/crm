class Executive < ApplicationRecord
  belongs_to :company, inverse_of: :executives
  belongs_to :representative, inverse_of: :executives, dependent: :destroy

  # accepts_nested_attributes_for :representative
end
