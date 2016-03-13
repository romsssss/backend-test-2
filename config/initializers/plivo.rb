if File.exists?("#{Rails.root}/config/plivo.yml")
  PLIVO_CONFIG = YAML.load_file("#{Rails.root}/config/plivo.yml")[Rails.env]
  raise "plivo configuration does not specify adapter" if PLIVO_CONFIG.nil?
  ENV['PLIVO_AUTH_ID'] = PLIVO_CONFIG['auth_id']
  ENV['PLIVO_AUTH_TOKEN'] = PLIVO_CONFIG['auth_token']
end

fail 'Plivo auth id/token not set' if ENV['PLIVO_AUTH_ID'].nil? || ENV['PLIVO_AUTH_TOKEN'].nil?
