module Helper
  
  $here = File.expand_path(File.dirname(__FILE__))
  
  
  def self.include_defaults
    #todo
  end
  
  def self.require_files filename
    filename.each do |file|
      require "#{$here}/../lib/build_em/#{file}"
    end if filename.class == Array
    require "#{$here}/../lib/build_em/#{filename}" if filename.class == String
  end
  
end