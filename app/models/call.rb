class Call < ActiveRecord::Base
  validates :uuid, :caller_id, :status, presence: true
  validates :uuid, uniqueness: true

  belongs_to :company_number
  belongs_to :user_number
  has_one :voicemail, dependent: :destroy

  def error?
    status == 'error'
  end

  def completed?
    status == 'completed'
  end

  class << self
    def create_from_params(params)
      company_number = CompanyNumber.find_by_sip_endpoint(params[:To])
      Call.create!(
        uuid: params[:CallUUID],
        caller_id: params[:From],
        caller_name: params[:CallerName],
        status: params[:CallStatus],
        company_number: company_number
      )
    end
  end
end
