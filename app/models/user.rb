class User < ActiveRecord::Base
  def self.from_omniauth(auth)

    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      puts auth.credentials
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.zone.at(auth.credentials.expires_at)
      user.save! if user.email.split('@')[1] == "telecomnancy.net"
    end
  end
end