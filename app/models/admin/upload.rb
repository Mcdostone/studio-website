class Admin::Upload < ActiveRecord::Base
	belongs_to :type
	belongs_to :event
	has_many :media
end	