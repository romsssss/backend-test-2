class PlivoCallsController < ApplicationController
  include Plivo

  skip_before_filter :verify_authenticity_token
  before_filter :set_call, only: %i(voicemail hangup fallback)

  def inbound
    fail 'Not an inbound call' if params[:Direction] != 'inbound'
    logger.debug '------------------------'
    logger.debug "Incoming Call"
    logger.debug '------------------------'

    @company_number = CompanyNumber.find_by_sip_endpoint(params[:To])
    @response = Response.new()

    @call = Call.create!(
      uuid: params[:CallUUID],
      caller_id: params[:From],
      caller_name: params[:CallerName],
      status: params[:CallStatus],
      company_number: @company_number
    )

    # Dials
    @user_numbers = @company_number.users.includes(:user_numbers).map(&:user_numbers).flatten
    dial_parameters = {
      callerId: params[:From],
      callerName: params[:CallerName],
      timeout: '10',
    }
    dial = @response.addDial(dial_parameters)
    @user_numbers.each do |user_number|
      dial.addUser(user_number.sip_endpoint)
    end

    # Voicemail
    @response.addSpeak("Leave your message after the tone")
    record_params = {
      action: "http://#{request.host_with_port}/plivo_calls/voicemail",
      method: 'POST',
      maxLength: '30',
      redirect: 'true'
    }
    @response.addRecord(record_params)

    logger.debug '------------------------'
    logger.debug @response.to_xml
    logger.debug '------------------------'

    respond_to do |format|
      format.xml { render xml: @response.to_xml }
    end
  end

  def voicemail
    logger.debug '------------------------'
    logger.debug "Voicemail"
    logger.debug '------------------------'

    @call.create_voicemail!(
      url: params[:RecordFile],
      duration: params[:RecordingDuration]
    )

    respond_to do |format|
      format.xml { render xml: {}.to_xml }
    end
  end

  def hangup
    logger.debug '------------------------'
    logger.debug "Hangup"
    logger.debug '------------------------'

    @call.update_attributes(
      hangup_cause: params[:HangupCause],
      status: params[:CallStatus],
      start_time: params[:StartTime],
      end_time: params[:EndTime],
      answer_time: params[:AnswerTime],
      duration: params[:Duration]
    )

    respond_to do |format|
      format.xml { render xml: {}.to_xml }
    end
  end

  def fallback
    logger.debug '------------------------'
    logger.debug "Fall back"
    logger.debug '------------------------'
    @call.update_attribute(:status, 'error')
    respond_to do |format|
      format.xml { render xml: {}.to_xml }
    end
  end

  private

  def set_call
    @call = Call.find_by_uuid(params[:CallUUID])
  end
end
