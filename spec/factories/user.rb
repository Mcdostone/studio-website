require 'ffaker'

FactoryGirl.define do
	factory :user do
		provider { 'google' }
		uid { FFaker::Guid::guid }
		first_name {FFaker::Name::first_name}
		last_name {FFaker::Name::last_name}		
		email { FFaker::Internet::email.split('@')[0] + '@telecomnancy.net' }
		oauth_token { FFaker::Guid::guid  }
		oauth_expires_at { FFaker::Time::datetime }
	
		trait :admin do
			authorization { Authorization.find_by(name: 'admin') }
		end

		trait :author do
			authorization { Authorization.find_by(name: 'viewer') }
		end

		trait :not_TN do
			email { FFaker::Internet::email }
		end

	end
end