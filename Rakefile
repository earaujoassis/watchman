require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

task default: :test
task spec: :test

desc 'Run the specs for the Watchman subproject as well'
task :watchtest do
  sh %{#{FileUtils::RUBY} -S bundle exec rspec}
end

desc 'Open an IRB console with the Watchman module available'
task :console do
  sh %{irb -r ./console}
end
