class User < ApplicationRecord
  belongs_to :authorization
  has_many :uploads
  after_initialize :set_defaults
  mount_uploader :avatar, AvatarUploader  

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.first_name = auth.info.first_name.capitalize
      user.last_name = auth.info.last_name.capitalize

      # Test if picture is the default picture of google account
      #user.picture = auth.info.image if(auth.info.image != DEFAULT_IMAGE)
      user.email = auth.info.email
      user.id_token = auth.extra.id_token
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.zone.at(auth.credentials.expires_at)
      
      if auth.extra.id_info.hd == 'telecomnancy.net' && user.email.split('@')[1] == 'telecomnancy.net'
        user.save! 
        return user
      else
        return nil
      end
    end
  end

  def admin?
    self.authorization.name == 'admin'
  end

  def author?
    self.authorization.name == 'author'
  end

  def viewer?
    self.authorization.name == 'viewer'
  end

  private
    def set_defaults
      self.authorization ||= Authorization.find_by(name: 'viewer')
      self.nickname ||= 'Fredlapouf'
    end
end