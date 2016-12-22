OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, Rails.application.secrets.GOOGLE_CLIENT_ID, Rails.application.secrets.GOOGLE_CLIENT_SECRET
  	{
      	:scope => 'email,profile,drive',
		:prompt => "select_account",
		:image_aspect_ratio => "square",
		:image_size => 50,
		:include_granted_scopes => 'true',
		:access_type => 'online'
  }
end