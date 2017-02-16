require "rails_helper"

RSpec.describe TypesController, :type => :controller do

  context 'not connected' do
    before do
      @type = FactoryGirl.create(:user)
    end
    subject { @type }

    describe 'GET #index' do
      it "should redirect to root path" do
        get :index
        expect(flash.keys).to_not be_empty
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET #show' do
      it "should redirect to root path" do
        get :show, :id => @type.id
        expect(flash.keys).to_not be_empty
        expect(response).to redirect_to(root_path)
      end
    end
end

  context 'connected' do

    before do
      @current = FactoryGirl.create(:user)
      @type = FactoryGirl.create(:type)
      sign_in @current
    end
    subject { @type }

    describe 'GET #index' do
      it "should return all types" do
        get :index
        expect(flash.keys).to be_empty
        expect(assigns(:types).size).to eq 1
        expect(response).to render_template('index')
      end
    end

    describe 'GET #show' do
      it "should return the type" do
        get :show, :id => @type.id
        expect(assigns(:type)).to eq @type
        expect(response).to render_template('show')
      end
    end

    describe 'GET #edit' do
      it "should not to be accessible" do
        expect(:get => :edit, :id => @type.id).not_to be_routable
      end
    end

    describe 'PUT #update' do
      it "should not to be accessible" do
        expect(:put => :update, :id => @type.id).not_to be_routable
      end
    end

    describe 'DELETE #' do
      it "should not to be accessible" do
        expect(:delete => :destroy, :id => @type.id).not_to be_routable
      end
    end
  end

end
