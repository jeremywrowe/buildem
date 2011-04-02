require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "executor"

describe BuildEm::Executor, "run" do
  
  before :each do
    @mock_kernel = mock(Kernel)
    @matcher = mock(BuildEm::ConditionMatcher)
  end

  describe "runs with default options" do
    
    it "executes the provided command and quits if no retries supplied" do
      command  = "pinky and the brain"
      executor = BuildEm::Executor.new([command,{}], @mock_kernel)
      run_and_exitstatus_with(command, "FAILURE", 8675308)
      executor.run.should == 8675308
    end
    
    it "raises an exception when something bad goes on" do
      command  = "foo bar"
      executor = BuildEm::Executor.new([command, {}], @mock_kernel)
      @mock_kernel.should_receive("run_command").with(command).and_raise("KA BOOM")
      expecting_exception("KA BOOM") { executor.run }
    end
    
  end
  
  describe "runs command with options" do
    
    it "executes the provided command 10 times when condition is not met" do
      command = "some really cool command"
      executor = BuildEm::Executor.new([command, {:retry_amount => 10}], @mock_kernel)
      10.times do
        run_and_exitstatus_with(command, "FAILURE", -1)
      end
      executor.run.should == -1
    end
    
    it "executes the provided command 3 times out of 10 when condition is met after 3 tries" do
      command = "command_to_run"
      executor = BuildEm::Executor.new([command, {:retry_amount => 10}], @mock_kernel)
      2.times do
        run_and_exitstatus_with(command, "FAILURE", -1)
      end
      run_and_exitstatus_with(command, "WINNER", 0)
      executor.run.should == 0
    end
    
    it "does not raise an exception when something bad goes on if :quit_on_error is false" do
      argz = ["command_to_run", {:quit_on_error => false}]
      executor = BuildEm::Executor.new(argz, @mock_kernel)
      @mock_kernel.should_receive("run_command").with("command_to_run").and_raise("KA BOOM")
      executor.run.should == nil
    end
    
  end
  
  private
  def run_and_exitstatus_with(command, output, exitstatus)
    @mock_kernel.should_receive("run_command").with(command).and_return(output)
    @mock_kernel.should_receive(:exitstatus).and_return(exitstatus)
  end
  
  
end