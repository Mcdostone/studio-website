require "rails_helper"

RSpec.describe Event, :type => :model do

  before do
    @medium = FactoryGirl.create(:medium)
  end
  subject { @medium }

  it 'destroy the medium' do
    @medium.destroy
    expect(Medium.count).to eq 0
  end

  it "destroy all medium's reports" do
    user = FactoryGirl.create(:user)
    (0..2).each do
      report = FactoryGirl.build(:report)
      report.medium = @medium
      report.user = user
      report.save!
    end
    expect(Report.count).to eq 3
    @medium.destroy
    expect(Report.count).to eq 0
  end
end
