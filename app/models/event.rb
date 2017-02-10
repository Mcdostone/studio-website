class Event < ApplicationRecord

	include PublicActivity::Model
	tracked
 	tracked owner: Proc.new{ |controller, model| @current_user }
	
	mount_uploader :cover, CoverUploader

	has_many :media
	after_initialize :set_defaults

	validates 	:name,
				presence: true,
				allow_blank: false

	private
		def set_defaults
			self.date_event = Time.now if(!self.date_event)
		end
end