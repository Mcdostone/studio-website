class Admin::Upload < ApplicationRecord
	belongs_to :type
	belongs_to :event
	has_many :media
end	