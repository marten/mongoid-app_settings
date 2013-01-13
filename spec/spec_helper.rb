$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'database_cleaner'
require 'mongoid'
require 'mongoid-app_settings'

ENV["MONGOID_ENV"] = "test"
if Mongoid::VERSION > '3'
  Mongoid.load!("#{File.dirname(__FILE__)}/mongoid3.yml")
else
  Mongoid.load!("#{File.dirname(__FILE__)}/mongoid2.yml")
end
Mongoid.logger.level = Logger::INFO

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
