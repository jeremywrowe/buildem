require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
Helper::include_defaults
Helper::require_files "file_opener"
include BuildEm

describe :file_opener, "load" do
  
  it "raises an exception stating that the file doesn't exist when its not there"
  it "raises an exception stating that the file is not readable"
  it "can open a file that exists"
  
end