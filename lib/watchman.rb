module Watchman
  ROOT = File.expand_path("../../", __FILE__)

  Dir.glob(File.join(ROOT, "lib", "watchman" "**", "*.rb")).each { |f| require f }
end
