require "rails_helper"

RSpec.describe Event, :type => :model do

  before do
    @event = FactoryGirl.create(:event)
  end
  subject { @event }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it '#destroy the event' do
    @event.destroy
    expect(Event.count).to eq 0
  end

  it "set medium's event to nil" do
    medium = FactoryGirl.build(:medium)
    medium.event = @event
    medium.save!
    @event.destroy
    medium.reload
    expect(Event.count).to eq 0
    expect(medium.event_id).to be_nil
    expect(medium.event).to be_nil
  end

end
