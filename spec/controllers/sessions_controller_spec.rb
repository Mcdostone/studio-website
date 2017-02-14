require "rails_helper"

RSpec.describe SessionsController, :type => :controller do


	context 'TN' do

		before do 
			request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:TN]
		end

		describe 'GET #create' do
			it "should successfully create a session" do
				session[:user_id].should be_nil
				get :create, provider: :google_oauth2
				session[:user_id].should_not be_nil
    	end
		end

		describe 'GET #destroy' do
		end

	end

end