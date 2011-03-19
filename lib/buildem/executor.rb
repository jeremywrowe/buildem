require "buildem/base"

class BuildEm::Executor
  
  attr_accessor :argz
  
  def initialize(args)
    @argz ||= args
  end
  
  def name
    BuildEm::Executor
  end
  
  def run
    # queued_run "publish.sh", :output => "publish_output.out", :errors => "publish_errors.out"
    begin
      `#{argz[0]} #{redirect_standard_err_and_out}`
    rescue Exception => e
      puts e
    end
  end
  
  private
  
  def redirect_standard_err_and_out
    ""
  end
  
  
end