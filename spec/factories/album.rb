FactoryGirl.define do
	factory :album do
    name { FFaker::NameMX.name }
    date { FFaker::Time.date }
	end
end
