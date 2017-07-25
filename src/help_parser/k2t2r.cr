module HelpParser
  def self.k2t(specs : TokensHash) : StringHash
    k2t = StringHash.new
    tokens = specs.select{|k,v| !(k==TYPES)}.values.flatten.select{|v|v.includes?('=')}
    tokens.each do |token|
      if match = VARIABLE.match(token) || LONG.match(token)
        name, type = match["k"], match["t"]
        k2t[name] = type if !k2t.has_key?(name)
        HelpParser.validate_consistent_variables
      else
        # Expected these to be caught earlier...
        raise SoftwareError.new("Unexpected string in help text: "+token)
      end
    end
    return k2t
  end

  def self.t2r(specs : TokensHash) : RegexHash | Nil
    if types = specs[TYPES]?
      t2r = RegexHash.new
      specs[TYPES].each do |pair|
        type, pattern = pair.as(Array(Token))
        begin
          t2r[type.as(String)] = Regex.new(pattern.as(String)[1..-2])
        rescue ArgumentError
          raise HelpError.new("Bad regex for #{type}: #{pattern}")
        end
      end
      return t2r
    end
    return nil
  end
end
