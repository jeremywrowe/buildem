# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "buildem/version"

Gem::Specification.new do |s|
  s.name        = "buildem"
  s.version     = BuildEm::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jeremy W. Rowe"]
  s.email       = ["jeremy.w.rowe@gmail.com"]
  s.homepage    = "http://jeremyrowe.com"
  s.summary     = %q{}
  s.description = %q{}
  s.add_dependency('process_pool', '>= 0.1.3')
  s.add_development_dependency('rspec')

  s.rubyforge_project = "buildem"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
