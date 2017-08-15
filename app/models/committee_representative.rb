class CommitteeRepresentative < ApplicationRecord
  belongs_to :committee
  belongs_to :representative
end
