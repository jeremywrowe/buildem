require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "base"

describe "base" do
  
  describe "inside" do
    it "can execute a command inside a directory" do
      inside "./spec/unit" do
        Dir.pwd.should =~ /spec\/unit$/i
      end
    end

    it "throws an exception when you go to an improper directory" do
      expecting_exception(Errno::ENOENT){inside("./spec/unitz"){ Dir.pwd }}
    end
  end
  
  describe "within" do
    it "can execute a command inside a directory" do
      within "./spec/unit" do
        Dir.pwd.should =~ /spec\/unit$/i
      end
    end
    
    it "throws an exception when you go to an improper directory" do
      expecting_exception(Errno::ENOENT){within("./spec/unitz"){ Dir.pwd }}
    end
  end
  
end

describe Kernel, "exitstatus" do
  
  it "can get the exit status of the last ran application" do
    capture(:stdout) { `pwd` }
    Kernel.exitstatus.should == 0
  end
  
end

describe Kernel, "run_command" do
  
  it "can run a command" do
    flexmock(Kernel) {|k| k.should_receive("`").with("awesome command").and_return("foo man shoe").once}
    Kernel.run_command("awesome command").should == "foo man shoe"
  end
  
end