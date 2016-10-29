class User < ActiveRecord::Base

  after_initialize :set_defaults

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name.capitalize
      user.picture = auth.info.image
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.zone.at(auth.credentials.expires_at)
      user.save! if user.email.split('@')[1] == "telecomnancy.net"
    end
  end

  private
    def set_defaults
      self.admin ||= false
      self.nickname ||= 'Fredlapouf'
    end
end