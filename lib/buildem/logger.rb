module Kernel
  
  def output_to(filename="output.log", stream=:stdout)
    if block_given?
      begin
        stream = stream.to_s
        eval "$#{stream} = StringIO.new"
        yield
        result = eval("$#{stream}").string
      ensure
        eval("$#{stream} = #{stream.upcase}")
      end
    else
      fail "output_to must be used in block format with a 'do' and 'end'."
    end
    
    File.open(filename, "w+") {|f| f.puts result }
    
  end
  
end