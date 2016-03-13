class FallbackCall
  include Sidekiq::Worker
  include Plivo

  # Mark the call as falty
  # @param call_uuid [String] uuid of the call to be dialed
  # @param params [Hash] information sent back by Plivo
  # @return [Boolean]
  def perform(call_uuid, params = {})
    call = Call.find_by_uuid(call_uuid)
    call.update_attribute(:status, 'error')
  end
end
