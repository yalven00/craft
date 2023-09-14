CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                             # required
    :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'],          # required
    :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'],      # required
    :region                 => 'us-west-2'
  }
  config.fog_directory  = ENV["#{Rails.env.upcase}_AWS_BUCKET"]                     # required
  config.fog_public     = true                                    # optional, defaults to true
  config.fog_attributes = {}  # optional, defaults to {}
end
