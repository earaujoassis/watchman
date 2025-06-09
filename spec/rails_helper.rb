require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require_relative '../config/environment'

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'shoulda/matchers'

# Rails.root.glob('spec/support/**/*.rb').sort_by(&:to_s).each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_paths = [ Rails.root.join('spec/fixtures') ]
  config.include FactoryBot::Syntax::Methods

  config.use_transactional_fixtures = true

  config.use_active_record = true

  # config.infer_spec_type_from_file_location!

  # config.filter_gems_from_backtrace("gem name")
  config.filter_rails_from_backtrace!
end
