class Event < ApplicationRecord
	has_many :media
	after_initialize :set_defaults
	validates_uniqueness_of :name
	validates :name, presence: true, allow_blank: false
	mount_uploader :cover, CoverUploader
	private
		def set_defaults
			self.date_event = Time.now if(!self.date_event)
		end
end