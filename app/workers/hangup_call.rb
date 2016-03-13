class HangupCall
  include Sidekiq::Worker
  include Plivo

  # Update call with hangup information
  # @param call_uuid [String] uuid of the call to be dialed
  # @param params [Hash] information sent back by Plivo
  # @return [Boolean]
  def perform(call_uuid, params = {})
    call = Call.find_by_uuid(call_uuid)
    return false if call.error?

    call.update_attributes(
      hangup_cause: params[:HangupCause],
      status: params[:CallStatus],
      start_time: params[:StartTime],
      end_time: params[:EndTime],
      answer_time: params[:AnswerTime],
      duration: params[:Duration]
    )
  end
end
