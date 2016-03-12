class User < ActiveRecord::Base
  has_many :user_numbers
  has_and_belongs_to_many :company_numbers
end
