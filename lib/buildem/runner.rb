require "buildem"
require 'buildem/base'


class BuildEm::Runner
    
  def self.start
    if ARGV.size == 1
      puts "running #{ARGV[0]}"
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