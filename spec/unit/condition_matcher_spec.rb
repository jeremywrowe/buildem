require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "condition_matcher"

describe BuildEm::ConditionMatcher, "match" do
  
  before :each do
    @matcher = BuildEm::ConditionMatcher.new
  end
  
  # match(return_code, output, condition)
  
  it "raises an exception when an unsupported condition is supplied" do
    unsupported_type = 1.00
    expecting_exception("unsupported type for condition") { @matcher.match(0,"foo", unsupported_type) } 
  end
  
  describe "output with string matching" do
    it "returns true when it finds a match" do
      @matcher.match(0,"foo", "foo").should == true
    end 
    it "returns true when it can not find a match" do
      @matcher.match(0,"foo", "bar").should == false
    end
  end
  
  describe "output with regexp matching" do
    it "returns true when it finds a match" do
      @matcher.match(0,"very complex output", /\w+\s+complex\s+\w+/).should == true
    end
    it "returns true when it can not find a match" do
      @matcher.match(0,"more [complex] output", /\w+\s+complex\s+\w+/).should == false
    end
  end

  describe "return code matching" do
    it "returns true when it finds a match" do
      @matcher.match(0,"SUCCESS", 0).should == true
    end
    it "returns true when it can not find a match" do
       @matcher.match(0,"FAILURE", 1).should == false
    end
  end
  
end