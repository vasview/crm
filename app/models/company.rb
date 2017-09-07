class Company < ApplicationRecord
  attr_accessor :total

  belongs_to :category
  belongs_to :industry
  belongs_to :city

  has_many :interactions
  has_many :interaction_results
  has_many :representatives
  has_many :executives, inverse_of: :company, dependent: :destroy

  accepts_nested_attributes_for :executives, allow_destroy: true
end
