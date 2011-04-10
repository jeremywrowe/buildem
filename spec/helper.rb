require "bundler/setup"
require 'fileutils'
include FileUtils
require 'buildem'

require 'rspec'
require 'test/unit'
require 'flexmock/test_unit'

$SPEC_ROOT = File.expand_path(File.dirname(__FILE__))

def require_files filename
  filename.each do |file|
    require "#{$SPEC_ROOT}/../lib/buildem/#{file}"
  end if filename.class == Array
  require "#{$SPEC_ROOT}/../lib/buildem/#{filename}" if filename.class == String
end
  
def within path
  cd path do
    yield
  end
end

RSpec.configure do |config|
  
  config.mock_with :flexmock
  
  def expecting_exception(clazz)
    begin
      yield
    rescue Exception => e
      case clazz
      when String
        e.message.should == clazz
        return
      when Regexp
        e.message.should =~ clazz
        return
      else
        e.class.should   == clazz
        return
      end
    end
    fail "Did not throw an exception like intended"
  end
  
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

  def source_root
    File.join(File.dirname(__FILE__), 'fixtures')
  end

  def destination_root
    File.join(File.dirname(__FILE__), 'sandbox')
  end

  alias :silence :capture
end