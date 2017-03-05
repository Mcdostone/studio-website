RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation), {except: %w[authorizations]}
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction, {except: %w[authorizations]}
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation, {except: %w[authorizations]}
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
