require "rails_helper"

RSpec.describe User, :type => :model do
	@user = FactoryGirl.create(:user)
	
	it { should respond_to :last_name }
	it { should respond_to :first_name }
	it { should respond_to :uid }
	it { should respond_to :email }
	it { should respond_to :authorization }    
	
end