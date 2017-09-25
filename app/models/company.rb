class Company < ApplicationRecord
  include Filterable

  attr_accessor :total, :color

  scope :category, -> (category_id) { where category_id: category_id }
  scope :status, -> (status) { where status: status }

  belongs_to :category
  belongs_to :industry
  belongs_to :city

  has_many :interactions
  has_many :interaction_results
  has_many :representatives
  has_many :executives, inverse_of: :company, dependent: :destroy

  accepts_nested_attributes_for :executives, allow_destroy: true

  def is_active?
    self.status == 'active' ? true : false
  end
end
