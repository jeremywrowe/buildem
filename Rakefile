require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
namespace :spec do
  
  desc "Run all of the system specs. [spec=system/foo.rb]"
  RSpec::Core::RakeTask.new(:system) do |spec|
    spec.pattern = 'spec/system/*_spec.rb'
    spec.rspec_opts = ['--color']
  end
  
  desc "Run all of the unit specs. [spec=unit/foo.rb]"
  RSpec::Core::RakeTask.new(:test) do |spec|
    spec.pattern = 'spec/unit/*_spec.rb'
    spec.rspec_opts = ['--color']
  end
  
end