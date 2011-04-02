class BuildEm::ConditionMatcher
  def match(return_code, output, condition)
    case condition
    when Regexp
      return false unless output =~ condition
    when String
      return false unless output == condition
    when Fixnum
      return false unless return_code == condition
    else
      raise "unsupported type for condition"
    end
    return true
  end
end