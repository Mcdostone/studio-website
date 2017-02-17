require 'ffaker'

FactoryGirl.define do
	factory :event do
    name { FFaker::NameMX.name }
    date { FFaker::Time.date }
	end
end
