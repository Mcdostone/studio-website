class Medium < ActiveRecord::Base

	belongs_to :type
	belongs_to :event
 	validates :id_file, uniqueness: true

#	mount_uploader :thumbnail, ThumbnailUploader

end