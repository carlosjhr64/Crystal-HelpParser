# Code here only active in development mode.
# Nothing here appears when --release compile optis is set.
# What this code does is find errors in the help text.
module HelpParser
  macro validate_duplicate_section
    {% if !flag?(:release) %}
      raise HelpError.new(DUPLICATE_SECTION, name) if specs.has_key?(name)
    {% end %}
  end

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
      raise HelpError.new(UNBALANCED_BRACKETS, spec) unless count==0
    {% end %}
  end

  macro validate_usage_tokens
    {% if !flag?(:release) %}
      words = Array(String).new
      tokens.flatten.each do |token|
        match = token.match(USAGE_FLAG_PATTERN) ||
                token.match(USAGE_LITERAL_PATTERN)  ||
                token.match(USAGE_VARIABLE_PATTERN) ||
                token.match(USAGE_FLAG_GROUP_PATTERN)
        raise HelpError.new(UNRECOGNIZED_USAGE_TOKEN, token) unless match
        words.push match["k"] # key
      end
      words.each_with_index do |word,i|
        raise HelpError.new(DUPLICATE_WORD, word) unless i==words.rindex(word)
      end
    {% end %}
  end

  macro validate_type_spec
    {% if !flag?(:release) %}
      raise HelpError.new(UNRECOGNIZED_TYPE_SPEC, spec) unless spec=~SPEC_TYPE_DEFINITION_PATTERN
    {% end %}
  end

  macro validate_exclusive_pair
    {% if !flag?(:release) %}
      raise HelpError.new(UNRECOGNIZED_EXCLUSIVE_SPEC, spec) unless spec=~SPEC_EXCLUSIVE_PAIR_PATTERN
    {% end %}
  end

  macro validate_option_spec
    {% if !flag?(:release) %}
      case spec
      when SPEC_SHORT_PATTERN,
        SPEC_LONG_PATTERN,
        SPEC_SHORT_LONG_PATTERN,
        SPEC_SHORT_LONG_DEFAULT_PATTERN
        # OK
      else
        raise HelpError.new(UNRECOGNIZED_OPTION_SPEC, spec)
      end
    {% end %}
  end

  private macro f2s(f)
    ({{f.id}}[1]=='-')? {{f.id}}[2..(({{f.id}}.index('=')||0)-1)] : {{f.id}}.lchop
  end

  macro validate_usage_specs
    {% if !flag?(:release) %}
      option_specs = specs.select{|a,b| !HelpParser.reserved(a)}
      flags = option_specs.values.flatten.select{|f|f[0]=='-'}.map{ |f| f2s(f) }
      if exclusive = specs[EXCLUSIVE]?
        seen = Set(String).new
        exclusive.each do |xs|
          xs = xs.as(Array(Token))
          k = xs.sort{|a,b|a.to_s<=>b.to_s}.join(" ")
          raise HelpError.new(DUPLICATE_EXCLUSIVE_SPEC, k) if seen.includes?(k)
          seen.add k
          xs.each do |x|
            raise HelpError.new(UNDEFINED_FLAG, x) unless flags.includes?(x)
          end
        end
      end
      flags.each_with_index do |flag,i|
        raise HelpError.new(DUPLICATE_FLAG, flag) unless i==flags.rindex(flag)
      end
      group = Array(String).new
      if specs_usage = specs[USAGE]?
        specs_usage.flatten.each do |token|
          if match = token.match(USAGE_FLAG_GROUP_PATTERN)
            key = match["k"]
            raise HelpError.new(SECTION_NOT_DEFINED, key) unless specs[key]?
            group.push(key)
          end
        end
      end
      specs.each do |key,tokens|
        raise HelpError.new(MISSING_CASES, key) unless tokens.size>0
        next if specs_usage.nil? || HelpParser.reserved(key)
        raise HelpError.new(MISSING_USAGE, key) unless group.includes?(key)
      end
    {% end %}
  end

  macro validate_consistent_variables
    {% if !flag?(:release) %}
      raise HelpError.new(INCONSISTENT_USE_OF_VARIABLE, name) unless type==k2t[name]
    {% end %}
  end

  macro validate_k2t2r
    {% if !flag?(:release) %}
      a,b = k2t.values.uniq.sort,t2r.keys.sort
      unless a==b
        c = (a+b).uniq.select{|x|!(a.includes?(x) && b.includes?(x))}
        raise HelpError.new(UNCOMPLETED_TYPES_DEFINITION, c.join(","))
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
          raise HelpError.new(DEFAULT_DOES_NOT_MATCH_TYPE, long, default, type, regex.inspect) unless regex=~default
        end
      end
    {% end %}
  end

  macro validate_no_extraneous_spaces
    {% if !flag?(:release) %}
      raise HelpError.new(EXTRANEOUS_SPACES) if spec == ""
    {% end %}
  end
end
