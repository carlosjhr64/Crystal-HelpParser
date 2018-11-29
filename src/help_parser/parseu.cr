module HelpParser
  def self.parseu(chars : Array(Char)) : Array(Token)
    tokens, token = Array(Token).new, ""
    while c = chars.shift?
      case c
      when ' ', '[', ']'
        unless token == ""
          tokens.push(token)
          token = ""
        end
        tokens.push HelpParser.parseu(chars) if c == '['
        return tokens if c == ']'
      else
        token += c
      end
    end
    tokens.push(token) unless token == ""
    return tokens
  end
end
