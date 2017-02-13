class Type < ApplicationRecord

	include PublicActivity::Model
	tracked owner: Proc.new{ |controller, model| controller.current_user }
	mount_uploader :cover, CoverUploader

	has_many :media
	has_many :upload
	has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy
	
	validates 	:name,
				uniqueness: true,
				presence: true,
				allow_blank: false

end