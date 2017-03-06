require "rails_helper"

RSpec.describe User, :type => :model do

	before do
		Rails.application.load_seed
		@user = FactoryGirl.create(:user)
	end
	subject { @user }

	it "should be a viewer " do
		puts @user.inspect
		expect(@user.viewer?).to be true
		expect(@user.author?).to be false
		expect(@user.admin?).to be false
	end

	it 'should be destroyed' do
		@user.destroy
		expect(User.count).to eq 0
	end

	it 'should belongs to TN.net' do
		expect(@user.email).to match(/@telecomnancy.net$/)
	end

	it "should have 'fredlapouf' as default nickname" do
		expect(@user.nickname.upcase).to eq 'fredlapouf'.upcase
	end

	it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of :email }
	it { should validate_presence_of(:first_name) }
	it { should validate_presence_of(:last_name) }
	it { should validate_presence_of(:uid) }
	it { should validate_uniqueness_of :uid }
	it { should validate_presence_of(:oauth_expires_at) }
	it { should validate_presence_of(:oauth_token) }

	context 'admin' do
		before do
			@user = FactoryGirl.create(:user, :admin)
		end

		it 'should be a admin' do
			expect(@user.viewer?).to be false
			expect(@user.author?).to be false
			expect(@user.admin?).to be true
		end
	end


	context 'author' do
		before do
			@user = FactoryGirl.create(:user, :author)
		end

		it 'should be a author' do
			expect(@user.author?).to be true
			expect(@user.viewer?).to be false
			expect(@user.admin?).to be false
		end
	end


	context 'not TN' do
		before do
			@user = FactoryGirl.build(:user, :not_TN)
		end

		it 'should not be accepted' do
			expect(@user.id).to be_nil
			expect {@user.save!}.to raise_error(ActiveRecord::RecordInvalid)
		end
	end

end
