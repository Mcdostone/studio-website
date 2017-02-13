class Event < ApplicationRecord

	include PublicActivity::Model
 	tracked owner: Proc.new{ |controller, model| controller.current_user }
	
	mount_uploader :cover, CoverUploader

	has_many :media
	has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

	after_initialize :set_defaults

	validates 	:name,
				uniqueness: true,
				presence: true,
				allow_blank: false

	private
		def set_defaults
			self.date_event = Time.now if(!self.date_event)
		end
end