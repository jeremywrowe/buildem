def windows
	platform_is_windows = RUBY_PLATFORM.downcase.include?("mswin")
	if block_given?
		if platform_is_windows
			yield
		end
	else
		platform_is_windows
	end
end

def linux
	platform_is_linux = RUBY_PLATFORM.downcase.include?("linux")
	if block_given?
		if platform_is_linux
			yield	
		end
	else
		platform_is_linux
	end
end

def osx
	platform_is_osx = RUBY_PLATFORM.downcase.include?("darwin")
	if block_given?
		if platform_is_osx
			yield	
		end
	else
		platform_is_osx
	end
end



