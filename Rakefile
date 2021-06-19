# frozen_string_literal: true

require "rake"

desc "Run the specs for the Watchman subproject as well"
task "watchman:test" do
  sh %{#{FileUtils::RUBY} -S bundle exec rspec}
end

desc "Open an IRB console with the Watchman module available"
task :console do
  sh %{irb -r ./console}
end

namespace :foreman do
  desc "Run the foreman Procfile"
  task :all do
    sh %{#{FileUtils::RUBY} -S bundle exec foreman start -p 3000 -e /dev/null}
  end

  task :scheduler do
    sh %{#{FileUtils::RUBY} -S bundle exec foreman start -p 3000 -e /dev/null scheduler}
  end

  task :web do
    sh %{#{FileUtils::RUBY} -S bundle exec hanami db migrate}
    sh %{#{FileUtils::RUBY} -S bundle exec foreman start -p 3000 -e /dev/null web}
  end
end

desc "Run the Rubocop code analyzer/linter"
task :lint do
  sh %{#{FileUtils::RUBY} -S bundle exec rubocop}
end

desc "Test all specs"
task :spec do
  sh %{#{FileUtils::RUBY} -S bundle exec rspec}
end

task default: [:lint, :spec]
