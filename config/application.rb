require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StudioWebsite
  class Application < Rails::Application

    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Paris'
    config.active_record.default_timezone = :local

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
			g.test_framework :rspec,
			:fixtures => true,
			:view_specs => false,
			:helper_specs => false,
			:routing_specs => false,
			:controller_specs => true,
			:request_specs => true
		end

		config.active_record.raise_in_transactional_callbacks = true

    ActsAsTaggableOn.remove_unused_tags = true
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      html_tag
    }
  end
end
