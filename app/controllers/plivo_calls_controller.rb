class PlivoCallsController < ApplicationController
  include Plivo

  skip_before_filter :verify_authenticity_token

  def inbound
    fail 'Not an inbound call' if params[:Direction] != 'inbound'

    @call = Call.create_from_params(params)
    xml_response = DialCall.new.perform(@call.uuid, request.host)

    respond_to do |format|
      format.xml { render xml: xml_response }
    end
  end

  def voicemail
    VoicemailCall.new.perform(params[:CallUUID], params)
    render nothing: true
  end

  def hangup
    HangupCall.new.perform(params[:CallUUID], params)
    render nothing: true
  end

  def fallback
    FallbackCall.perform_async(params[:CallUUID], params)
    render nothing: true
  end
end
