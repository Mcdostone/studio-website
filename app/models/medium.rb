class Medium < ApplicationRecord
	belongs_to :type
	belongs_to :event
	belongs_to :upload
	has_many :likes
	mount_uploader :file, MediumUploader
end