class Report < ApplicationRecord

	belongs_to :medium
	belongs_to :user

	validates :message,
		presence: true,
	 	:length => { :maximum => 500 ,:too_long => "Seulement %{count} caractères sont autorisés pour le message!" }

	validates :user,
		presence: true

	validates :medium,
		presence: true

end
