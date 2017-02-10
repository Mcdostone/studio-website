class Type < ApplicationRecord

	include PublicActivity::Model
	tracked
	mount_uploader :cover, CoverUploader

	has_many :media
	has_many :upload

	validates 	:name,
				presence: true,
				uniqueness: true

end