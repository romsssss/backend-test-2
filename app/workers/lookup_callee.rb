class LookupCallee
  include Sidekiq::Worker
  include Plivo

  # Lookup callee identity for a given call
  # @param call_uuid [String] uuid of the call to be dialed
  # @return [Boolean]
  def perform(call_uuid)
    call = Call.find_by_uuid(call_uuid)
    return false unless call.completed?

    plivo = RestAPI.new(ENV['PLIVO_AUTH_ID'], ENV['PLIVO_AUTH_TOKEN'])

    children_calls = plivo.get_cdrs(parent_call_uuid: call.uuid).second['objects']
    return false if children_calls.size != 1

    answered_by = UserNumber.find_by_sip_endpoint(children_calls.first['to_number'])
    unless answered_by.nil?
      call.user_number = answered_by
      call.save
    end
  end
end
