require 'ffaker'

FactoryGirl.define do
	factory :type do
    name { FFaker::NameMX.name }
	end
end
