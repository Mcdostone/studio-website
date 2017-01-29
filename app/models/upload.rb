class Upload < ApplicationRecord
	belongs_to :type
	belongs_to :event
	belongs_to :user
	has_many :media
end