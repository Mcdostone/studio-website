require "rails_helper"

RSpec.describe UsersController, :type => :controller do

  context 'not connected' do
    before do
      @user = FactoryGirl.create(:user)
    end

    describe 'GET #index' do
      it "should redirect to root path" do
        get :index
        expect(flash.keys).to_not be_empty
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET #show' do
      it "should redirect to root path" do
        get :show, :id => @user.id
        expect(flash.keys).to_not be_empty
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET #show' do
      it 'should redirect to root path' do
        get :show, :id => @user.id
        expect(flash.keys).to_not be_empty
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'GET #edit' do
      it 'should redirect to root path' do
        get :show, :id => @user.id
        expect(flash.keys).to_not be_empty
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'PUT #update' do
      it 'should redirect to root path' do
        post :update, :id => @user.id
        expect(flash.keys).to_not be_empty
        expect(response).to redirect_to(root_path)
      end
    end

  end

  context 'connected' do

    before do
      @current = FactoryGirl.create(:user)
      sign_in @current
    end

    describe 'GET #index' do
      it "should return all users" do
        FactoryGirl.create(:user)
        get :index
        expect(flash.keys).to be_empty
        expect(assigns(:users).size).to eq 2
        expect(response).to render_template('index')
      end
    end

    describe 'GET #show' do
      it "should return the user" do
        get :show, :id => @current.id
        expect(assigns(:user)).to eq @current
        expect(response).to render_template('show')
      end
    end

    describe 'GET #edit' do
      it "should edit the user" do
        get :edit, :id => @current.id
        expect(assigns(:user)).to eq @current
        expect(response).to render_template('edit')
      end
    end

    describe 'PUT #update' do
      it "should edit the user" do
        nickname = 'Mcdostone'
        @params = {:nickname => nickname}
        patch :update, :id => @current.id, :user => @params
        expect(assigns(:user).nickname).to eq nickname
        expect(response).to redirect_to(user_path(@current))
      end

      it "should not edit the user" do
        nickname = 'Mcdostone'
        @params = {:email => nickname}
        patch :update, :id => @current.id, :user => @params
        expect(assigns(:user).email).to eq @current.email
        expect(response).to redirect_to(user_path(@current))
      end
    end
  end

end
