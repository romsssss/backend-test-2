class CompanyNumber < ActiveRecord::Base
  validates :sip_endpoint, uniqueness: true
  has_and_belongs_to_many :users


  def user_numbers
    self.users.includes(:user_numbers).map(&:user_numbers).flatten
  end

end
