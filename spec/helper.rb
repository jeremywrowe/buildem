require 'fileutils'
include FileUtils
require 'buildem'
require 'rspec'

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