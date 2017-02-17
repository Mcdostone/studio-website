class Medium < ApplicationRecord
	belongs_to :type
	belongs_to :event
	belongs_to :upload
	has_many :likes
	has_many :reports
	mount_uploader :file, MediumUploader

end
