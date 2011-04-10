require 'rubygems'
require 'buildem'
require 'fileutils'
include FileUtils

module Kernel
  def exitstatus
    $?
  end
  
  def run_command(cmd) 
    `#{cmd}`
  end
end

def inside path
  cd path do
    yield
  end
end

alias :within :inside
