require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "file_opener"


describe BuildEm::FileOpener, "load" do
  
  it "raises an exception stating that the file doesn't exist when its not there"
  it "raises an exception stating that the file is not readable"
  it "can open a file that exists"
  
end