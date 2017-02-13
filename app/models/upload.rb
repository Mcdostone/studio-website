class Upload < ApplicationRecord
	
	include PublicActivity::Model
 	tracked owner: Proc.new{ |controller, model| controller.current_user }

	belongs_to :event
	belongs_to :user
	belongs_to :type
	
	has_many :media
	has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

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