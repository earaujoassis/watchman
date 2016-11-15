# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require_relative '../config/environment'
require 'minitest/autorun'

Hanami::Application.preload!

require 'bundler/setup'
Bundler.setup(:default, :development, :test)

require File.expand_path(File.dirname(__FILE__) + '../../lib/watchman')

RSpec.configure do |config|
end
