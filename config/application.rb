require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StudioWebsite
  class Application < Rails::Application

    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Paris'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

  end
end
