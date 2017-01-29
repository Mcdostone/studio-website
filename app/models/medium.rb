class Medium < ApplicationRecord

	belongs_to :type
	belongs_to :event
	belongs_to :upload
 	#validates :id_file, uniqueness: true
	mount_uploader :file, MediumUploader
end