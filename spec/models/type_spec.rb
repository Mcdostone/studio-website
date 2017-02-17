require "rails_helper"

RSpec.describe Type, :type => :model do

  before do
    @type = FactoryGirl.create(:type)
  end
  subject { @type }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it '#destroy' do
    @type.destroy
    expect(Type.count).to eq 0
  end

  it "set medium's type to nil" do
    medium = FactoryGirl.build(:medium)
    medium.type = @type
    medium.save!
    @type.destroy
    medium.reload
    expect(Type.count).to eq 0
    expect(medium.type_id).to be_nil
    expect(medium.type).to be_nil
  end

end
