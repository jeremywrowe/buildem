require "buildem/base"
require "buildem/condition_matcher"

class BuildEm::Executor
  
  attr_accessor :argz
  
  def initialize(args, kernel=Kernel, matcher=BuildEm::ConditionMatcher.new)
    @kernel = kernel
    @argz ||= args
    @matcher = matcher
  end
  
  def name
    BuildEm::Executor
  end
  
  def run
    optz = argz[1]
    quit_on_error = (optz[:quit_on_error].nil?  ? true : optz[:quit_on_error])
    retry_amount  = (optz[:retry_amount].nil?    ? 1 : optz[:retry_amount])
    condition     = (optz[:retry_condition].nil? ? 0 : optz[:retry_condition])
    executions    = 0
    begin
      puts "retrying command [#{argz[0]}]" if executions > 0
      executions += 1
      @comamnd_output     = @kernel.run_command("#{argz[0]}")
      @command_exitstatus = @kernel.exitstatus
      match = @matcher.match(@command_exitstatus, @comamnd_output, condition)
      puts @comamnd_output if match
      return @command_exitstatus if match
    rescue Exception => e
      if quit_on_error
        raise e
      else
        #put to output log or specified log
      end
    end while executions < retry_amount
    @command_exitstatus
  end
  
  private
  
  def redirect_standard_error_and_out
    ""
  end
  
  
end