require "rails_helper"

RSpec.describe SessionsController, :type => :controller do


	context 'TN' do

		before do
			request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:TN]
		end

		describe 'GET #create' do
			it "should successfully create a session" do
				#session[:user_id].should be_nil
				get :create, provider: :google_oauth2
				expect(session[:user_id]).to_not be_nil
			end
		end

		describe 'GET #destroy' do
			it "should successfully create a session" do
				delete :destroy
				expect(session[:user_id]).to be_nil
			end
		end
	end


	context 'unknown' do

		before do
			request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:unknown]
		end

		describe 'GET #create' do
			it "should not create a session" do
				get :create, provider: :google_oauth2
				expect(flash.keys).to_not be_empty
				expect(session[:user_id]).to be_nil
			end
		end

		describe 'GET #destroy' do
			it "should successfully create a session" do
				delete :destroy
				expect(session[:user_id]).to be_nil
			end
		end
	end

end
