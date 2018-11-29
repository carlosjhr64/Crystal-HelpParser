module HelpParser
  def self.k2t(specs : Hash(String, Array(Token))) : Hash(String, String)
    k2t = Hash(String, String).new
    tokens = specs.select { |k, v| !(k == TYPES) }.values.flatten.select { |v| v.includes?('=') }
    tokens.each do |token|
      if match = USAGE_VARIABLE_PATTERN.match(token) || SPEC_LONG_PATTERN.match(token)
        name, type = match["k"], match["t"]
        k2t[name] = type if !k2t.has_key?(name)
        HelpParser.validate_consistent_variables
      else
        # Expected these to be caught earlier...
        raise SoftwareError.new(UNEXPECTED_STRING_IN_HELP_TEXT, token)
      end
    end
    return k2t
  end

  def self.t2r(specs : Hash(String, Array(Token))) : Hash(String, Regex) | Nil
    if types = specs[TYPES]?
      t2r = Hash(String, Regex).new
      types.each do |pair|
        type, pattern = pair.as(Array(Token))
        begin
          t2r[type.as(String)] = Regex.new(pattern.as(String)[1..-2])
        rescue ArgumentError
          raise HelpError.new(BAD_REGEX, type, pattern)
        end
      end
      return t2r
    end
    return nil
  end
end
