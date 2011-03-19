  
# configuration.workers 2
# configuration.output_file "output.out"
# configuration.error_file "errors.out"

class BuildEm::Configuration
  
  attr_accessor :workers, :output_file, :error_file, :run_output
  
  def initialize(optz={})
    @workers ||= (optz[:workers] || 1)
    @output_file ||= (optz[:output_file] || "output.out")
    @error_file ||= (optz[:error_file] || "error.out")
    @run_output ||= optz[:run_output]
  end
  
end