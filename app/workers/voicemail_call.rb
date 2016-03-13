class VoicemailCall
  include Sidekiq::Worker
  include Plivo

  # Create a new voicemail for a given call
  # @param call_uuid [String] uuid of the call to be dialed
  # @param params [Hash] information sent back by Plivo
  # @return [Boolean]
  def perform(call_uuid, params = {})
    call = Call.find_by_uuid(call_uuid)
    call.create_voicemail!(
      url: params[:RecordFile],
      duration: params[:RecordingDuration]
    )
    true
  end
end
