CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],
    :aws_secret_access_key  => ENV['AWS_ACCESS_KEY_SECRET'],
  }
  config.fog_directory  = ENV['AWS_BUCKET']
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end
