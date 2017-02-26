require 'rails_helper'

RSpec.describe Album, type: :model do


  before do
    @album = FactoryGirl.create(:album)
  end
  subject { @album }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it '#destroy the album' do
    @album.destroy
    expect(Album.count).to eq 0
  end

  it "set medium's album to nil" do
    medium = FactoryGirl.build(:medium)
    medium.album = @album
    medium.save!
    @album.destroy
    medium.reload
    expect(Album.count).to eq 0
    expect(medium.album_id).to be_nil
    expect(medium.album).to be_nil
  end

end
