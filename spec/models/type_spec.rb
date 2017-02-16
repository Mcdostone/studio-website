require "rails_helper"

RSpec.describe Type, :type => :model do

  context 'when connected' do
    before do
      @type = FactoryGirl.create(:type)
    end
    subject { @type }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it 'destroy the type' do
      @type.destroy
      expect(Type.count).to eq 0
    end
  end

end
