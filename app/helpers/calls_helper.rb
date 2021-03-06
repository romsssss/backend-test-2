module CallsHelper
  def format_voicemail(voicemail)
    return '-' if voicemail.nil?
    link_to Time.at(voicemail.duration).utc.strftime("%Mmin %Ss"), voicemail.url
  end

  def format_user_number(user_number)
    return '-' if user_number.nil?
    truncate(user_number.sip_endpoint)
  end

  def format_duration(duration)
    return '-' if duration.nil?
    "#{duration}s"
  end
end
