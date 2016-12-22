require 'open-uri'

class Medium < ActiveRecord::Base
	belongs_to :type
	belongs_to :event

	has_attached_file :thumbnail,
		:path => ":rails_root/public/thumbnails/:basename_:style.:extension",
		:url => "/thumbnails/:basename_:style.:extension",
		:styles => { :thumb => "150x150" }

	validates_attachment :thumbnail, content_type: { content_type: /\Aimage\/.*\Z/ }

end