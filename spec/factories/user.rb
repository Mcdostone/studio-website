require 'ffaker'

FactoryGirl.define do
	factory :user do
		provider { 'google' }
		uid { FFaker::Guid::guid }
		first_name {FFaker::Name::first_name}
		last_name {FFaker::Name::last_name}		
		email { FFaker::Internet::email.split('@')[0] + '@telecomnancy.net' }
		id_token { FFaker::Guid::guid  }
		oauth_token { FFaker::Guid::guid  }
		oauth_expires_at { FFaker::Time::datetime }
	end
end