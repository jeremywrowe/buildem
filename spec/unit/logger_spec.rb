require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "logger"
require 'tempfile'

describe Kernel, "output_to" do
  
  after :each do
    rm_rf "output.log" if File.exist? "output.log"
  end
  
  it "captures multiple lines" do
    output_to { 
      puts "hi"
      puts "bye"
      puts "wooh wooooooh"
    }
    File.open("output.log", "r") {|f| f.readlines.size.should == 3}
  end
  
  it "captures standard out" do
    output_to("output.log", :stdout) {
     puts `pwd`
    }
    File.open("output.log", "r") {|f| f.readline.should =~ /buildem/ }
  end
  
  it "captures standard error" do
    output_to("output.log", :stderr) { 
      $stderr.puts "err"
    }
    File.open("output.log", "r") {|f| f.readlines.should == ["err\n"] }
  end
  
  it "captures standard out by default" do
    output_to { puts "hi" }
    File.open("output.log", "r") {|f| f.readlines.should == ["hi\n"] }
  end
  
  it "writes output to default filename of output.log" do
    output_to { puts "hi" }
    File.exist?("output.log").should == true
  end
  
  it "writes to a provided filename" do
    output_to ("woowoo.txt") { puts "heee-che-bon" }
    File.open("woowoo.txt", "r") {|f| f.readlines.should == ["heee-che-bon\n"] }
    rm_rf "woowoo.txt"
  end
  
  it "throws an exception if a block is not given" do
    expecting_exception("output_to must be used in block format with a 'do' and 'end'.") { Kernel.output_to }
  end
  
end