class CompanyNumber < ActiveRecord::Base
  validates :sip_endpoint, uniqueness: true
end
