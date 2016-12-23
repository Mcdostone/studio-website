class Medium < ActiveRecord::Base

	belongs_to :type
	belongs_to :event

	mount_uploader :thumbnail, ThumbnailUploader

end