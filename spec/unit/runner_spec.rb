require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "runner"

describe BuildEm::Runner, "start" do
  
  it "runs the program" do
    ARGV.replace ["#{here}/helper/examples/blank_file.buildem"]
    capture(:stdout) {BuildEm::Runner.start}.strip.should == "running #{here}/helper/examples/blank_file.buildem\nfinished #{here}/helper/examples/blank_file.buildem"
  end
  
  it "runs the program" do
    ARGV.replace ["#{here}/helper/examples/not_there.buildem"]
    lambda { capture(:stdout) {BuildEm::Runner.start} }.should raise_error(LoadError)
  end
  
  it "spits out usage when the user doesn't supply a filename" do
    ARGV.replace []
    capture(:stdout) {BuildEm::Runner.start}.should == usage_banner
  end
  
  describe "execution flow" do
    
    before do
      
    end
    
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