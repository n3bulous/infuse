require 'rubygems'
require 'rake/gempackagetask'
require 'rake/testtask'

require 'lib/infuse/version'

task :default => :test

spec = Gem::Specification.new do |s|
  s.name             = 'infuse'
  s.version          = Infuse::Version.to_s
  s.has_rdoc         = true
  s.extra_rdoc_files = %w(README.textile)
  s.rdoc_options     = %w(--main README.textile)
  s.summary          = "Create HTML slide shows with a simple DSL!"
  s.author           = 'Kevin McFadden'
  s.email            = 'kevin+github@conceptsahead.com'
  s.homepage         = 'http://conceptsahead.com'
  s.files            = %w(README.textile Rakefile) + Dir.glob("{lib,test}/**/*")
  s.executables    = ['infuse']

  # Can probably go older...
#  s.add_dependency('redcloth')
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

desc 'Generate the gemspec to serve this Gem from Github'
task :github do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, 'w') {|f| f << spec.to_ruby }
  puts "Created gemspec: #{file}"
end
