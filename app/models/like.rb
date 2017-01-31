class Like < ApplicationRecord
	belongs_to :user
	belongs_to :medium
	validates :user, :uniqueness => {:scope => :medium}
end
