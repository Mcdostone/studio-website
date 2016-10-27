class Event < ActiveRecord::Base
	has_many :media

	after_initialize :set_defaults

	validates_uniqueness_of :name
	validates :name, presence: true

	def set_defaults
		self.date = Time.now
	end

end
