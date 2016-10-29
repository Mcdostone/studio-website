class User < ActiveRecord::Base

  belongs_to :authorization

  after_initialize :set_defaults

  DEFAULT_IMAGE = 'https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg'

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name.capitalize
      
      # Test if picture is the default picture of google account      
      user.picture = auth.info.image if(auth.info.image != DEFAULT_IMAGE)

      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.zone.at(auth.credentials.expires_at)
      user.save! #if user.email.split('@')[1] == "telecomnancy.net"
    end
  end

  def admin?
    self.authorization.name == 'admin'
  end

  def author?
    self.authorization.name == 'author' || self.admin?
  end

  private
    def set_defaults
      self.authorization ||= Authorization.find_by(name: 'viewer')
      self.nickname ||= 'Fredlapouf'
    end
end