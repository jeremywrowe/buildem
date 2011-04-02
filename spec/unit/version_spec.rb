require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")
require_files "version"

describe BuildEm, "VERSION" do
  it "has the proper version number" do
    BuildEm::VERSION.should == "0.0.4"
  end
end