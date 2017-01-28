CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = 'mybucketname'
  config.aws_acl    = :public_read
  config.asset_host = 'https://mybucketname.s3-us-west-1.amazonaws.com'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

  config.aws_credentials = {

    # Configuration for Amazon S3
    :provider              => 'AWS',
    :access_key_id     => 'myaccessid',
    :secret_access_key => 'mysecretkey',
    :region                => 'eu-central-1',
  }

   config.storage = :aws
   config.cache_dir = '/tmp/studio'                

end