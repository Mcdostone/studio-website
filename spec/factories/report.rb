require 'ffaker'

FactoryGirl.define do
	factory :report do
    message { FFaker::Lorem.sentence }

		trait :long_message do
			message { FFaker::Lorem.paragraphs * 3 }
		end

	end
end
