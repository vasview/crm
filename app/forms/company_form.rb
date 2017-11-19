class CompanyForm < BaseForm
  property :name
  property :category_id
  property :industry_id
  property :city_id
  property :address
  property :work_phone
  property :mobile_phone
  property :email
  property :birthdate
  property :notes
  property :status
  property :entry_date
  property :exit_date
  property :exit_reason

  property :firstname
  property :lastname
  property :middlename
  property :job_position_id

  validates :name,              presence: true
  validates :category_id,       presence: true
  validates :industry_id,       presence: true
  validates :entry_date,        presence: true

  validates :firstname,       presence: true
  validates :lastname,        presence: true
  validates :job_position_id, presence: true
end