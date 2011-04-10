require File.expand_path(File.dirname(__FILE__)+"/../helper.rb")

describe BuildEm, "VERSION" do
  it "has the proper version number" do
    BuildEm::VERSION.should == "0.0.6"
  end
end