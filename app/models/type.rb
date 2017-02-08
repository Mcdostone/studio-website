class Type < ApplicationRecord
	has_many :media
	has_many :upload

	mount_uploader :cover, CoverUploader

	validates_uniqueness_of :name
	validates :name,
		presence: true,
		allow_blank: false
end
