OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	provider :google_oauth2, Rails.application.secrets.GOOGLE_CLIENT_ID, Rails.application.secrets.GOOGLE_CLIENT_SECRET
  	{
		#client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}},
		:name => "Tessss",
		:scope => "email, profile, plus.me, drive.readonly",
		:prompt => "select_account",
		:image_aspect_ratio => "square",
		:image_size => 50
  }
end