class Medium < ApplicationRecord
	belongs_to :type
	belongs_to :event
	belongs_to :upload
	mount_uploader :file, MediumUploader
end