require 'rake'
require 'hanami/rake_tasks'
require 'rake/testtask'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

Rake::TestTask.new do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.libs    << 'spec'
  t.warning = false
end

desc 'Run the specs for the Watchman subproject as well'
task :watchtest do
  sh %{#{FileUtils::RUBY} -S bundle exec rspec}
end

desc 'Open an IRB console with the Watchman module available'
task :console do
  sh %{irb -r ./console}
end

desc 'Run the foreman Procfile'
task :foreman do
  sh 'foreman start -p 3000 -e /dev/null'
end
