require 'rake'

desc 'Open an IRB console with the Watchman module available'
task :console do
  sh %{irb -r ./console}
end
