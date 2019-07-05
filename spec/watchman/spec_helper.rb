require "bundler/setup"
Bundler.setup(:default, :development, :test)

require File.expand_path(File.dirname(__FILE__) + "../../lib/watchman")

RSpec.configure do |config|
end
