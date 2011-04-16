require 'spec/platforms.rb'

source "http://rubygems.org"
gemspec

group :test do
	gem "rspec"
	gem "autotest"
	osx do
	  gem "autotest-growl"
	  gem "autotest-fsevent"
        end
	gem "flexmock"
	gem "rcov"
end
