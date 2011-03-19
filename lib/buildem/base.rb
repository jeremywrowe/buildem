require 'rubygems'
require "buildem"

def windows?
  return java.lang.System.get_property("os.name")[/windows/i] if RUBY_PLATFORM == "java"
  return RUBY_PLATFORM[/mswin/]
end
