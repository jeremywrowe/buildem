require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"

task :default => ["spec:unit", "spec:system"]

namespace :spec do
  
  desc "Run all of the system specs. [spec=system/foo.rb]"
  RSpec::Core::RakeTask.new(:system) do |spec|
    spec.pattern    = 'spec/system/*_spec.rb'
    spec.rspec_opts = %w{--color'}
  end
  
  desc "Run all of the unit specs. [spec=unit/foo.rb]"
  RSpec::Core::RakeTask.new(:unit) do |spec|
    spec.pattern    = 'spec/unit/*_spec.rb'
    spec.rspec_opts = %w{--color -f d}
  end
  
  RSpec::Core::RakeTask.new('test:rcov') do |spec|
    rm_f "coverage"
    spec.pattern    = 'spec/unit/*_spec.rb'
    spec.rcov       = true
    spec.rspec_opts = %w{--color}
    spec.rcov_opts  = %w{--exclude spec,gems\/}
  end

  
end
