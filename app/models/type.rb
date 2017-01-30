class Type < ApplicationRecord
	has_many :media
	has_many :upload
	validates_uniqueness_of :name
	validates :name, presence: true, allow_blank: false
	mount_uploader :cover, CoverUploader
end
