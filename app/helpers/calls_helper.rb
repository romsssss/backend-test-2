module CallsHelper
  def format_voicemail(voicemail)
    return 'N/A' if voicemail.nil?
    link_to Time.at(voicemail.duration).utc.strftime("%Mmin %Ss"), voicemail.url
  end
end
