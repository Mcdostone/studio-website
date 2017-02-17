require "rails_helper"

RSpec.describe Report, :type => :model do

  before do
    @report = FactoryGirl.build(:report)
    @user = FactoryGirl.create(:user)
    @medium = FactoryGirl.create(:medium)
    @report.user = @user
    @report.medium = @medium
    @report.save!
  end
  subject { @report }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:medium) }
  it { should validate_presence_of(:message) }

  it 'destroy the report' do
    @report.destroy
    expect(Report.count).to eq 0
    expect(@medium.reports).to be_empty
  end

  context 'when report too long' do
    before do
      @report = FactoryGirl.build(:report, :long_message)
      @report.user = @user
      @report.medium = @medium
    end
    subject { @report }

    it 'not save the report' do
      expect(@report.valid?).to be false
      expect(@report.errors.messages).to_not be_empty
    end

  end
end
