class RepresentativeForm < BaseForm
  property :firstname
  property :middlename
  property :lastname
  property :work_phone
  property :mobile_phone
  property :email
  property :company_id
  property :job_position_id
  property :birthdate
  property :notes
  property :company_head
  property :fullname
  property :preferences

  validates :firstname,       presence: true
  validates :lastname,        presence: true
  validates :company_id,      presence: true
  validates :job_position_id, presence: true
end