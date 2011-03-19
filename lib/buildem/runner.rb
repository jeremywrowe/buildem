require "buildem"
require 'buildem/base'
require 'buildem/configuration'
require 'buildem/executor'
require 'process_pool'

module Kernel
  def unorderd
    puts "Started unordered sequence"
    yield
    $pool = ProcessPool.new($configuration.workers)
    puts $configuration.workers
    $jobs.each do |command|
      $pool.schedule(command,command.argz)
    end
    $pool.start
    $pool.shutdown
  end
  
  def queued_run(command, optz = {})
    optz = {:foo => "bar", :moo => "cow"}
    $jobs << BuildEm::Executor.new([command,optz])
  end
  
  def run(command, optz = {})
    BuildEm::Executor.new([command,optz]).run
  end
end

class BuildEm::Runner
  $jobs = []
  def self.start
    if ARGV.size == 1
      puts "running #{ARGV[0]}"
      $configuration = BuildEm::Configuration.new
      load ARGV[0]
      puts "finished #{ARGV[0]}"
    else
      puts usage
    end
  end
  
  private
  
    def self.usage
<<-USAGE

-----------------------------------------------------------------
                            BUILD'EM
-----------------------------------------------------------------

  usage: buildem filename.buildem

-----------------------------------------------------------------
USAGE
    end
  
end