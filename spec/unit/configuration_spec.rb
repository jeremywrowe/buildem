require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "configuration"

# configuration.workers 2
# configuration.output_file "output.out"
# configuration.error_file "errors.out"

describe BuildEm::Configuration, "workers" do
  
  it "has a default worker of 2" do
    BuildEm::Configuration.new.workers.should eq 2
  end
  
  it "sets workers through initilization" do
    BuildEm::Configuration.new(:workers => 99).workers.should eq 99
  end
  
  it "sets workers" do
    config = BuildEm::Configuration.new
    config.workers = 55
    config.workers.should eq 55
  end
  
end

describe BuildEm::Configuration, "output_file" do
  
  it "has a default output_file of output.out" do
    BuildEm::Configuration.new.output_file.should eq "output.out"
  end
  
  it "sets output_file through initilization" do
    BuildEm::Configuration.new(:output_file => "go.daddy").output_file.should eq "go.daddy"
  end
  
  it "sets output_file" do
    config = BuildEm::Configuration.new
    config.output_file = "foo.bar"
    config.output_file.should eq "foo.bar"
  end
  
end

describe BuildEm::Configuration, "error_file" do
  
  it "has a default error_file of error.out" do
    BuildEm::Configuration.new.error_file.should eq "error.out"
  end
  
  it "sets error_file through initilization" do
    BuildEm::Configuration.new(:error_file => "slow.down").error_file.should eq "slow.down"
  end
  
  it "sets error_file" do
    config = BuildEm::Configuration.new
    config.error_file = "foo.bar"
    config.error_file.should eq "foo.bar"
  end
  
end

describe BuildEm::Configuration, "run_output" do
  
  it "has a default run_output of nil" do
    BuildEm::Configuration.new.run_output.should eq nil
  end
  
  it "sets run_output through initilization" do
    BuildEm::Configuration.new(:run_output => "execution_log").run_output.should eq "execution_log"
  end
  
  it "sets run_output" do
    config = BuildEm::Configuration.new
    config.run_output = "foo.bar"
    config.run_output.should eq "foo.bar"
  end
  
end