require 'bundler/gem_tasks'

task :default => :test

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

desc 'Generate code coverage report'
task :coverage do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].invoke
end

require 'rdoc/task'
RDoc::Task.new :doc do |t|
  t.title = "subcheat #{Subcheat::VERSION}"
  t.main = 'README.rdoc'
  t.rdoc_dir = 'doc'
  t.rdoc_files.include('README.rdoc', 'lib/**/*.rb')
end
