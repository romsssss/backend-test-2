class CompanyNumber < ActiveRecord::Base
  validates :sip_endpoint, uniqueness: true
  has_and_belongs_to_many :users
end
