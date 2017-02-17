require "rails_helper"

RSpec.describe Event, :type => :model do

  context 'when connected' do
    before do
      @event = FactoryGirl.create(:event)
    end
    subject { @event }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it 'destroy the type' do
      @event.destroy
      expect(Event.count).to eq 0
    end
  end

end
