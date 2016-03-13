class DialCall
  include Sidekiq::Worker
  include Plivo

  # Simultaneous dials for given call
  # @param call_uuid [String] uuid of the call to be dialed
  # @param fqdn [String] Fully qualified domain name of the voicemail server
  # @return [String] xml response expected by plivo
  def perform(call_uuid, fqdn)
    call = Call.find_by_uuid(call_uuid)
    fail 'Call is not in a state to be dialed' unless call.status == 'ringing'

    response = Response.new()

    # Simultaneous dials
    dial_parameters = {
      callerId: call.caller_id,
      callerName: call.caller_name,
      timeout: '10'
    }
    dial = response.addDial(dial_parameters)
    call.company_number.user_numbers.each do |user_number|
      dial.addUser(user_number.sip_endpoint)
    end

    # Voicemail
    response.addSpeak("Leave your message after the tone")
    record_params = {
      action: "http://#{fqdn}/plivo_calls/voicemail",
      method: 'POST',
      maxLength: '30',
      redirect: 'true'
    }
    response.addRecord(record_params)

    response.to_xml
  end
end
