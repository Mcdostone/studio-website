require "rails_helper"

RSpec.describe MediaController, :type => :controller do

  context 'not connected' do
    before do
      @type = FactoryGirl.create(:user)
    end
    subject { @type }

    describe 'GET #index' do
      it "should redirect to login path" do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end

    describe 'GET #show' do
      it "should redirect to login path" do
        get :show, :id => @type.id
        expect(response).to redirect_to(login_path)
      end
    end
end

  context 'connected' do

    before do
      @current = FactoryGirl.create(:user)
			@medium = FactoryGirl.create(:medium)
			sign_in @current
    end
    subject { @medium }

    describe 'GET #index' do
      it "should return all media" do
				FactoryGirl.create(:medium)
        get :index
				expect(flash.keys).to be_empty
        expect(assigns(:media).size).to eq 2
        expect(response).to render_template('index')
      end
    end

    describe 'GET #show' do
      it { should respond_with :not_found }

      #it "should return the type" do
      #	get :show, { :id => @medium.id }, { "Accept" => "application/json" }
			#	expect(assigns(:medium)).to eq @medium
        #end
    end

    describe 'GET #edit' do
      it "should not to be accessible" do
        expect(:get => :edit, :id => @medium.id).not_to be_routable
      end
    end

    describe 'PUT #update' do
      it "should not to be accessible" do
        expect(:put => :update, :id => @medium.id).not_to be_routable
      end
    end

    describe 'DELETE #' do
      it "should not to be accessible" do
        expect(:delete => :destroy, :id => @medium.id).not_to be_routable
      end
    end
  end

end
