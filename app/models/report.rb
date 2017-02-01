class Report < ApplicationRecord

	belongs_to :medium
	belongs_to :user

	validates :message, presence: true, allow_blank: false
	validates :user, presence: true
	validates :medium, presence: true
end
