class UserNumber < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :sip_endpoint, uniqueness: true
end
