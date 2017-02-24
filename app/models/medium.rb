class Medium < ApplicationRecord
	belongs_to :type
	belongs_to :event
	belongs_to :upload

	has_many :likes
	has_many :reports,
		dependent: :destroy

	acts_as_taggable
	acts_as_votable

	mount_uploader :file, MediumUploader

	def count_likes
		self.get_likes.size
	end

	def is_liked?(user)
		user.liked? self
	end

end
