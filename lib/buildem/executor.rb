require "buildem/base"

class BuildEm::Executor
  
  attar_accessor :argz
  
  def initialize(args)
    @argz ||= args
  end
  
  def name
    BuildEm::Executor
  end
  
  def run
    puts "running --v"
    @argz.each_with_index do |a,i|
      puts "\t\targz[#{i}] = #{a}"
    end
    begin
      start = Time.now
      sleep 2
      puts Time.now - start
    rescue Exception => e
      puts e
    end
  end
  
end