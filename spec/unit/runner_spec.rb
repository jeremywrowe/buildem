require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "runner"

describe BuildEm::Runner, "process_standard_in" do
  
  before :each do
    @mock_kernel = flexmock(:kernel, Kernel)
    @mock_argv   = flexmock(:argv, ARGV)
  end
  
  it "can handle user arguments" do
    @mock_argv.should_receive("empty?").and_return(false).once
    BuildEm::Runner.new(@mock_kernel, @mock_argv).process_standard_in
  end
  
  it "can handle standard in with no value" do
    @mock_argv.should_receive("empty?").and_return(true).once
    @mock_kernel.should_receive(:gets).once
    BuildEm::Runner.new(@mock_kernel, @mock_argv).process_standard_in
  end
  
  it "stops when the command 'start' is issued" do
    @mock_argv.should_receive("empty?").and_return(true).once
    @mock_kernel.should_receive(:gets).once
    BuildEm::Runner.new(@mock_kernel, @mock_argv).process_standard_in
  end
    
end

describe Kernel, "queued_run" do
  
  it "has the correct number of jobs" do
    30.times { @mock_kernel.queued_run("foo",{}) }
    $jobs.size.should == 30
    $jobs = []
  end
  
  it "can add a job" do
    101.times { |t|
      @mock_kernel.queued_run("foo",{}) 
      $jobs.size.should == t+1
    }
    $jobs = []
  end
  
end

describe BuildEm::Runner, "start" do
  
  it "runs the program" do
    ARGV.replace ["#{here}/helper/examples/blank_file.buildem"]
    capture(:stdout) {BuildEm::Runner.new.start}.strip.should == "running #{here}/helper/examples/blank_file.buildem\nfinished #{here}/helper/examples/blank_file.buildem"
  end
  
  it "runs the program" do
    ARGV.replace ["#{here}/helper/examples/not_there.buildem"]
    lambda { capture(:stdout) {BuildEm::Runner.new.start} }.should raise_error(LoadError)
  end
  
  it "spits out usage when the user doesn't supply a filename" do
    ARGV.replace []
    capture(:stdout) {BuildEm::Runner.new.start}.should == usage_banner
  end
  
  private
  
  def here
    File.expand_path(File.dirname(__FILE__))
  end
  
  def usage_banner
<<-USAGE

-----------------------------------------------------------------
                            BUILD'EM
-----------------------------------------------------------------

  usage: buildem filename.buildem

-----------------------------------------------------------------
USAGE
    
  end
    
end