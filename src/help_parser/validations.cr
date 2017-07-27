module HelpParser
  macro validate_line_chars
    {% if !flag?(:release) %}
      count = 0
      chars.each do |c|
        if c=='['
          count += 1
        elsif c==']'
          count -= 1
        end
        break if count<0
      end
      raise HelpError.new("Unbalance brackets: "+line) unless count==0
    {% end %}
  end

  macro validate_usage_tokens
    {% if !flag?(:release) %}
      words = Strings.new
      tokens.flatten.each do |token|
        match = token.match(FLAG)     ||
                token.match(LITERAL)  ||
                token.match(VARIABLE) ||
                token.match(FLAG_GROUP)
        raise HelpError.new("Unrecognized usage token: #{token}") unless match
        words.push match["k"] # key
      end
      words.each_with_index do |word,i|
        raise HelpError.new("Duplicate word: #{word}") unless i==words.rindex(word)
      end
    {% end %}
  end

  macro validate_usage_spec
    {% if !flag?(:release) %}
      # TODO: Symmetry demands this macro,
      # but I can't think of any help text errors I'm not already catching.
    {% end %}
  end

  macro validate_type_spec
    {% if !flag?(:release) %}
      raise HelpError.new("Unrecognized type spec: "+spec) unless spec=~TYPE_DEF
    {% end %}
  end

  macro validate_option_spec
    {% if !flag?(:release) %}
      case spec
      when SHORT, LONG, SHORT_LONG, SHORT_LONG_DEFAULT
        # OK
      else
        raise HelpError.new("Unrecognized option spec: #{spec}")
      end
    {% end %}
  end

  macro validate_usage_specs
    {% if !flag?(:release) %}
      option_specs = specs.select{|a,b| !(a==USAGE || a==TYPES)}
      flags = option_specs.values.flatten.select{|f|f[0]=='-'}.map{|f|HelpParser.f2s(f)}
      flags.each_with_index do |flag,i|
        raise HelpError.new("Duplicate flag: "+flag) unless i==flags.rindex(flag)
      end   
      group = Array(String).new 
      specs_usage = specs[USAGE]?
      unless specs_usage.nil?
        specs_usage.flatten.each do |token|
          if match = token.match(FLAG_GROUP)
            key = match["k"]
            raise HelpError.new("No #{key} section given.") unless specs[key]?
            group.push(key)
          end
        end
      end
      specs.each do |key,tokens|
        raise HelpError.new("No #{key} cases given.") unless tokens.size>0
        next if specs_usage.nil? || key==USAGE || key==TYPES
        raise HelpError.new("No usage given for #{key}.") unless group.includes?(key)
      end
    {% end %}
  end

  macro validate_consistent_variables
    {% if !flag?(:release) %}
      raise HelpError.new("Inconsistent use of variable: #{name}") unless type==k2t[name]
    {% end %}
  end

  macro validate_k2t2r
    {% if !flag?(:release) %}
      a,b = k2t.values.uniq.sort,t2r.keys.sort
      unless a==b
        c = (a+b).uniq.select{|x|!(a.includes?(x) && b.includes?(x))}
        raise HelpError.new("Uncompleted types definition: #{c.join(",")}")
      end
      @specs.each do |section,tokens|
        next if section==USAGE || section==TYPES
        tokens.each do |words|
          next if words.size<2
          default = words[-1].as(String)
          next if default[0]=='-'
          long_type = words[-2].as(String)
          i = long_type.index('=')
          next if i.nil?
          long = long_type[2..(i-1)]
          type = long_type[(i+1)..-1]
          regex = t2r[type]
          raise HelpError.new("Default not #{type}: #{long}") unless regex=~default
        end
      end
    {% end %}
  end

  macro validate_no_extraneous_spaces
    {% if !flag?(:release) %}
      raise HelpError.new("Extraneous spaces in help.") if spec == ""
    {% end %}
  end
end
