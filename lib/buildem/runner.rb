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
    puts "Finished #{$jobs.size} unordered jobs"
  end
  
  def queued_run(command, optz = {})
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
      begin
        puts "running #{ARGV[0]}"
        $configuration = BuildEm::Configuration.new
        load ARGV[0]
      ensure
        puts "finished #{ARGV[0]}"
      end
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