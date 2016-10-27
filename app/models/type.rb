class Type < ActiveRecord::Base
	has_many :media
	
	validates_uniqueness_of :name
end
