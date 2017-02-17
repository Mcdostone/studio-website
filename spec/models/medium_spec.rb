require "rails_helper"

RSpec.describe Event, :type => :model do

  context 'when connected' do
    before do
      @medium = FactoryGirl.create(:medium)
    end
    subject { @medium }

    it 'destroy the medium' do
      @medium.destroy
      expect(Medium.count).to eq 0
    end
  end

end
