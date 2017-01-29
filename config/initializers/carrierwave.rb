module CarrierWave
  
  module MiniMagick
    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage.to_s)
        img = yield(img) if block_given?
        img
      end
    end

    def optimize_thumbnail(percentage)
      manipulate! do |img|
        img.strip
        img.combine_options do |c|
          c.quality(percentage.to_s)
          c.depth "8"
          c.interlace "plane"
        end
        img
      end
    end
  end


  CarrierWave.configure do |config|
    config.storage =      :aws
    config.aws_bucket =    Rails.application.secrets.AWS_BUCKET_NAME
    config.aws_acl =      :public_read
    
    config.aws_authenticated_url_expiration = 20
    config.aws_attributes = {
    expires: 1.week.from_now.httpdate,
      cache_control: 'max-age=20'
    }

    config.aws_credentials = {
      provider:               'AWS',
      aws_access_key_id:      Rails.application.secrets.AWS_ACCESS_KEY_ID,
      aws_secret_access_key:  Rails.application.secrets.AWS_SECRET_ACCESS_KEY,
      region:                 Rails.application.secrets.AWS_REGION
    }

    # -----------------
    
    config.fog_provider = 'fog/aws'
    config.fog_authenticated_url_expiration = 10
    config.fog_credentials = {
      provider:               'AWS',
      aws_access_key_id:      Rails.application.secrets.AWS_ACCESS_KEY_ID,
      aws_secret_access_key:  Rails.application.secrets.AWS_SECRET_ACCESS_KEY,
      region:                 Rails.application.secrets.AWS_REGION,
      host:                   Rails.application.secrets.AWS_HOST,
      endpoint:               Rails.application.secrets.AWS_ENDPOINT
    }
    config.fog_directory  = Rails.application.secrets.AWS_BUCKET_NAME
    config.fog_public     = false
    config.fog_attributes = { 'Cache-Control' => "max-age=#{30.day.to_i}" }


    config.cache_dir = '/tmp/studio'
  end
end