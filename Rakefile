require 'rake/testtask'

Rake::TestTask.new(:spec) do |t|
  t.libs << 'lib' << 'spec'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
end

Rake::TestTask.new(:acceptance) do |t|
  t.libs << 'lib' << 'scenarios'
  t.pattern = 'scenarios/*/*.rb'
  t.verbose = true
end

task :default => [:spec, :acceptance]
