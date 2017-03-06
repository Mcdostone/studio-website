class User < ApplicationRecord
	belongs_to :authorization
	has_many :uploads

	after_initialize :set_defaults

	mount_uploader :avatar, AvatarUploader

	acts_as_voter

	validates :first_name,
		presence: true,
		allow_blank: false

	validates :last_name,
		presence: true,
		allow_blank: false

	validates :email,
		presence: true,
		allow_blank: false,
		uniqueness: true#,
		#format: { with: /@telecomnancy.net\z/, message: 'Seuls les étudiants de TN.net sont autorisés !'}

  validates :uid,
    presence: true,
    allow_blank: false,
		uniqueness: true

  validates :oauth_token,
    presence: true,
    allow_blank: false

  validates :oauth_expires_at,
		presence: true,
		allow_blank: false


	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			#user.provider = auth.provider
			user.uid = auth.uid
			user.first_name = auth.info.first_name.capitalize
			user.last_name = auth.info.last_name.capitalize
			user.email = auth.info.email
			#user.id_token = auth.extra.id_token
			user.oauth_token = auth.credentials.token
			user.oauth_expires_at = Time.zone.at(auth.credentials.expires_at)
			#if auth.extra.id_info.hd == 'telecomnancy.net'
			user.save!
			return user
		end
	end

	def admin?
		return self.authorization.name == 'admin'
	end

	def author?
		return self.authorization.name == 'author'
	end

	def viewer?
		return self.authorization ? self.authorization.name == 'viewer' : true
	end

	private
		def set_defaults
			self.authorization ||= Authorization.find_by(name: 'viewer')
			self.nickname ||= 'Fredlapouf'
		end
end
