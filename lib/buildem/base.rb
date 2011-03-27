require 'rubygems'
require 'buildem'
require 'fileutils'
include FileUtils

def windows?
  return java.lang.System.get_property("os.name")[/windows/i] if RUBY_PLATFORM == "java"
  return RUBY_PLATFORM[/mswin/]
end

def inside path
  cd path do
    yield
  end
end

alias :within :inside
