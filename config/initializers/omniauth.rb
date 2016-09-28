OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '212621071280-sjjdcrj2g47uk27nc0ona1dfdtm3bk6a.apps.googleusercontent.com', 'Fbncv9ErGkBiKHtpcw8f4tyJ', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end