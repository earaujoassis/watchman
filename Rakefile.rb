require 'rake'

desc 'Open an IRB console with the Watchman module available'
task :console do
  sh %{irb -r ./console}
end

desc 'Run the specs for the sequel-seed'
task :test do
  sh %{#{FileUtils::RUBY} -S bundle exec rspec}
end

task default: [:test]
