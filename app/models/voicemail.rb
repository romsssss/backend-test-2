class Voicemail < ActiveRecord::Base
  validates :url, presence: true
  belongs_to :call
end
