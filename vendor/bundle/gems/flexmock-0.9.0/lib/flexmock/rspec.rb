#!/usr/bin/env ruby

#---
# Copyright 2003-2011 by Jim Weirich (jim.weirich@gmail.com).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#+++

require 'flexmock/base'

class FlexMock
  if defined?(::RSpec)
    SpecModule = RSpec
  else
    SpecModule = Spec
  end

  class RSpecFrameworkAdapter
    def assert_block(msg, &block)
      SpecModule::Expectations.fail_with(msg) unless yield
    end

    def assert_equal(a, b, msg=nil)
      message = msg || "Expected equal"
      assert_block(message + "\n<#{a}> expected, but was\n<#{b}>") { a == b }
    end

    class AssertionFailedError < StandardError; end
    def assertion_failed_error
      SpecModule::Expectations::ExpectationNotMetError
    end
  end

  @framework_adapter = RSpecFrameworkAdapter.new
end
