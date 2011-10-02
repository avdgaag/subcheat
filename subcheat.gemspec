# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "subcheat/version"

Gem::Specification.new do |s|
  s.name        = 'subcheat'
  s.version     = Subcheat::VERSION
  s.authors     = ['Arjan van der Gaag']
  s.email       = ['arjan@arjanvandergaag.nl']
  s.homepage    = 'http://github.com/avdgaag/subcheat'
  s.summary     = 'Wrapper for Subversion CLI'
  s.description = 'Wrap the Subversion CLI to extract some usage patterns into commands'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'cucumber'
  s.add_development_dependency 'mocha', '>= 0.9.8'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'rdoc', '~> 3.9'
end
