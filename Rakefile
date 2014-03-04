require 'rake/testtask'

Rake::TestTask.new(:unit) do |t|
  t.libs << 'lib' << 'spec'
  t.pattern = 'spec/{xednese/**/*_spec.rb,*_spec.rb}'
  t.verbose = true
end

Rake::TestTask.new(:acceptance) do |t|
  t.libs << 'lib' << 'spec'
  t.pattern = 'spec/acceptance/*_spec.rb'
  t.verbose = true
end

task :default => [:unit, :acceptance]
