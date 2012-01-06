# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "process_pool"
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adam Pohorecki"]
  s.date = "2010-02-17"
  s.email = "adam@pohorecki.pl"
  s.extra_rdoc_files = ["LICENSE", "README", "TODO"]
  s.files = ["LICENSE", "README", "TODO"]
  s.homepage = "http://github.com/psyho/process_pool"
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.11"
  s.summary = "ProcessPool with interchangeable job queue backends for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
  end
end
