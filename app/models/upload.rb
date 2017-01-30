class Upload < ApplicationRecord
	belongs_to :type
	belongs_to :event
	belongs_to :user
	belongs_to :type
	
	has_many :media
	validates :user, presence: true
	validates :event, presence: true
	validates :type, presence: true
	
	after_initialize :set_defaults

  private
    def set_defaults
      self.event ||= Event.all.sample
      self.type ||= Type.all.sample
      end
end