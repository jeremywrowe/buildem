require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "executor"

describe BuildEm::Executor, "name" do
  it "has the correct name" do
    BuildEm::Executor.new(["command",{}]).name.should == BuildEm::Executor
  end
end

describe BuildEm::Executor, "run" do
  
  before :each do
    @mock_kernel = flexmock(Kernel)
    @matcher     = flexmock(BuildEm::ConditionMatcher.new)
  end

  describe "with default options" do
    
    it "executes the provided command and quits if no retries supplied" do
      command  = "pinky and the brain"
      run_and_exitstatus_with(command, "FAILURE")
      capture(:stdout) { BuildEm::Executor.new([command,{}], @mock_kernel, @matcher).run.should == 0 }
    end
    
    it "raises an exception when something bad goes on" do
      command  = "foo bar"
      @mock_kernel.should_receive("run_command").with(command).and_raise("KA BOOM")
      capture(:stdout) { expecting_exception("KA BOOM") { BuildEm::Executor.new([command, {}], @mock_kernel, @matcher).run } }
    end
    
  end
  
  describe "command retry interactions" do
    
    it "executes the provided command 50 times and raises an error when condition is not met" do
      command = "urr"
      50.times { run_and_exitstatus_with(command, "FAILURE", -1) }
      capture(:stdout) { expecting_exception("Failed to execute [urr]. Tried 50 time(s), expected match was [0] got [-1].") { BuildEm::Executor.new([command, {:retry_amount => 50, :quit_on_error => true}], @mock_kernel, @matcher).run.should == -1 } }
    end
    
    it "executes the provided command 10 times when condition is not met" do
      command = "some really cool command"
      10.times { run_and_exitstatus_with(command, "FAILURE", -1) }
      capture(:stdout) { BuildEm::Executor.new([command, {:retry_amount => 10, :quit_on_error => false}], @mock_kernel, @matcher).run.should == -1 }
    end
    
    it "executes the provided command 3 times out of 10 when condition is met after 3 tries" do
      command = "command_to_run"
      2.times { run_and_exitstatus_with(command, "FAILURE", -1) }
      run_and_exitstatus_with(command, "WINNER", 0)
      capture(:stdout) { BuildEm::Executor.new([command, {:retry_amount => 10}], @mock_kernel, @matcher).run.should == 0 }
    end
    
    it "does not raise an exception when something bad goes on if :quit_on_error is false" do
      @mock_kernel.should_receive("run_command").with("command_to_run").and_raise("KA BOOM")
      capture(:stdout) { BuildEm::Executor.new(["command_to_run", {:quit_on_error => false}], @mock_kernel, @matcher).run.should == nil }
    end
    
  end
  
  describe "command can handle conditions" do
    
    it "is successful when condition is met" do
      command = "er powel"
      run_and_exitstatus_with(command, "WINNER", 55, 55)
      capture(:stdout) { BuildEm::Executor.new([command, {:retry_condition => 55}], @mock_kernel, @matcher).run.should == 55 }
    end
    
    it "executes the provided command raises an error when condition is not met" do
      command = "fooz"
      run_and_exitstatus_with(command, "FAILURE", -1) 
      capture(:stdout) { expecting_exception("Failed to execute [fooz]. Tried 1 time(s), expected match was [0] got [-1].") { BuildEm::Executor.new([command, {}], @mock_kernel, @matcher).run.should == -1 } }
    end
    
  end
  
  private
  def run_and_exitstatus_with(command, output, exitstatus=0, condition = 0)
    @mock_kernel.should_receive(:run_command).with(command).and_return(output).once.ordered
    @mock_kernel.should_receive(:exitstatus).and_return(exitstatus).once.ordered
    @matcher.should_receive(:match).with(exitstatus, output, condition).and_return(exitstatus == condition).once.ordered
  end
  
end