class Call < ActiveRecord::Base
  validates :uuid, :caller_id, :status, presence: true
  validates :uuid, uniqueness: true

  belongs_to :company_number
end
