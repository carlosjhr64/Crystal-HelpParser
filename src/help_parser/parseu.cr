module HelpParser
  def self.parseu(chars : Chars) : Tokens
    tokens,token = Tokens.new,""
    while c = chars.shift?
      case c
      when ' ','[',']'
        unless token==""
          tokens.push(token)
          token = ""
        end
        tokens.push HelpParser.parseu(chars) if c=='['
        return tokens if c==']'
      else
        token += c
      end
    end
    tokens.push(token) unless token==""
    return tokens
  end

  def self.parseu(line : String) : Tokens
    chars = line.chars
    HelpParser.validate_line_chars
    tokens = HelpParser.parseu(chars)
    HelpParser.validate_usage_tokens
    return tokens
  end
end
