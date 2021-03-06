module HelpParser
  class Completion
    def initialize(
      @options : Options,
      @specs : Hash(String, Array(Token)),
      @cache : Hash(String, String | Array(String)) = Hash(String, String | Array(String)).new
    )
      usage if @specs.has_key?(USAGE)
      pad
      types
      exclusive if @specs.has_key?(EXCLUSIVE)
    end

    def exclusive
      keys = @options.to_h.keys
      @specs[EXCLUSIVE].each do |xs|
        if keys.count { |k| xs.includes?(k.to_s) } > 1
          raise UsageError.new(EXCLUSIVE_KEYS, xs.as(Array(Token)).join(" "))
        end
      end
    end

    def usage
      size = @options.to_h.size
      @specs[USAGE].each do |cmd|
        raise SoftwareError.new(EXPECTED_TOKENS) unless cmd.is_a?(Array(Token))
        begin
          i = matches(cmd)
          raise NoMatch.new unless size == i
          # Variables:
          @cache.each { |k, v| @options[k] = v }
          return
        rescue NoMatch
          next
        ensure
          @cache.clear
        end
      end

      dict = Set(String).new
      @specs.each do |k, v|
        next if HelpParser.reserved(k)
        v.flatten.map { |w| w.scan(/\w+/).first[0] }.each { |w| dict.add(w) }
      end
      typos = @options.to_h.keys.select { |k| !k.is_a?(UInt8) && !dict.includes?(k.to_s) }
      raise UsageError.new(UNRECOGNIZED, typos.join(" ")) unless typos.empty?

      raise UsageError.new(MATCH_USAGE)
    end

    def types
      if t2r = HelpParser.t2r(@specs)
        k2t = HelpParser.k2t(@specs)
        HelpParser.validate_k2t2r
        @options.to_h.each do |key, value|
          next unless key.is_a?(String)
          if type = k2t[key]?
            regex = t2r[type]
            case value
            when String
              raise UsageError.new("--#{key}=#{value} !~ #{type}=#{regex.inspect}") unless value =~ regex
            when Array(String)
              value.each do |string|
                raise UsageError.new("--#{key}=#{string} !~ #{type}=#{regex.inspect}") unless string =~ regex
              end
            else
              raise UsageError.new("--#{key} !~ #{type}=#{regex.inspect}")
            end
          end
        end
      end
    end

    def pad
      # Synonyms and defaults:
      hash = @options.to_h
      @specs.each do |section, options|
        next if section == USAGE || section == TYPES
        options.each do |words|
          next unless words.as(Array(Token)).size > 1
          first, second, default = words[0].as(String), words[1].as(String), words[2]?
          if first[0] == '-'
            if second[0] == '-'
              i = second.index('=') || 0
              short, long = first[1], second[2..(i - 1)]
              if hash.has_key?(short)
                if hash.has_key?(long)
                  raise UsageError.new(REDUNDANT, short, long)
                end
                @options[long] = (default.nil?) ? true : default.as(String)
              elsif value = @options[long]?
                @options[short] = true
                if value == true && !default.nil?
                  hash.delete(long)
                  @options[long] = default.as(String)
                end
              end
            else
              i = first.index('=') || 0
              long, default = first[2..(i - 1)], second
              value = @options[long]?
              if value == true
                hash.delete(long)
                @options[long] = default
              end
            end
          end
        end
      end
    end

    private macro f2k(f)
      ({{f.id}}[1]=='-')? {{f.id}}[2..(({{f.id}}.index('=')||0)-1)] : {{f.id}}[1]
    end

    def matches(cmd : Array(Token), i : UInt8 = 0_u8) : UInt8
      keys = @options.to_h.keys
      cmd.each do |token|
        if token.is_a?(Array(Token))
          begin
            i = matches(token, i)
          rescue NoMatch
            # OK, NEVERMIND!
          end
          next
        elsif m = USAGE_FLAG_GROUP_PATTERN.match(token)
          group, plus = m["k"], m["p"]?
          key = keys[i]?
          raise NoMatch.new if key.nil? || key.is_a?(UInt8)
          list = @specs[group].flatten.select { |f| f[0] == '-' }.map { |f| f2k(f) }
          raise NoMatch.new unless list.includes?(key)
          unless plus.nil?
            loop do
              key = keys[i + 1_u8]?
              break if key.nil? || key.is_a?(UInt8) || !list.includes?(key)
              i += 1_u8
            end
          end
        elsif m = USAGE_VARIABLE_PATTERN.match(token)
          key = keys[i]?
          raise NoMatch.new unless key.is_a?(UInt8)
          variable, plus = m["k"], m["p"]?
          if plus.nil?
            @cache[variable] = @options[key]
          else
            strings = Array(String).new
            strings.push @options[key]
            loop do
              key = keys[i + 1_u8]?
              break unless key.is_a?(UInt8)
              strings.push @options[key]
              i += 1_u8
            end
            @cache[variable] = strings
          end
        else # literal
          key = keys[i]?
          raise NoMatch.new if key.nil? || @options[key] != token
        end
        i += 1_u8
      end
      return i
    end
  end
end
