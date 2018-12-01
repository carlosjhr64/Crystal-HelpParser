module HelpParser
  class Completion
    def initialize(
      @hash : ArgvHash,
      @specs : Hash(String, Array(Token)),
      @cache : Hash(String, String | Array(String)) = Hash(String, String | Array(String)).new
    )
      usage if @specs.has_key?(USAGE)
      pad
      types
    end

    def usage
      @specs[USAGE].each do |cmd|
        raise SoftwareError.new(EXPECTED_TOKENS) unless cmd.is_a?(Array(Token))
        begin
          i = matches(cmd)
          raise NoMatch.new unless @hash.size == i
          @cache.each { |k, v| @hash[k] = v } # Variables
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
      typos = @hash.keys.select { |k| !k.is_a?(UInt8) && !dict.includes?(k.to_s) }
      raise UsageError.new(UNRECOGNIZED, typos.join(" ")) unless typos.empty?

      raise UsageError.new(MATCH_USAGE)
    end

    def types
      if t2r = HelpParser.t2r(@specs)
        k2t = HelpParser.k2t(@specs)
        HelpParser.validate_k2t2r
        @hash.each do |key, value|
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
      @specs.each do |section, options|
        next if section == USAGE || section == TYPES
        options.each do |words|
          next unless words.as(Array(Token)).size > 1
          first, second, default = words[0].as(String), words[1].as(String), words[2]?
          if first[0] == '-'
            if second[0] == '-'
              i = second.index('=') || 0
              short, long = first[1], second[2..(i - 1)]
              if @hash.has_key?(short)
                if @hash.has_key?(long)
                  raise UsageError.new(REDUNDANT, short, long)
                end
                @hash[long] = (default.nil?) ? true : default.as(String)
              elsif value = @hash[long]?
                @hash[short] = true
                if value == true && !default.nil?
                  @hash.delete(long)
                  @hash[long] = default.as(String)
                end
              end
            else
              i = first.index('=') || 0
              long, default = first[2..(i - 1)], second
              value = @hash[long]?
              if value == true
                @hash.delete(long)
                @hash[long] = default
              end
            end
          end
        end
      end
    end

    def matches(cmd : Array(Token), i : UInt8 = 0_u8) : UInt8
      keys = @hash.keys
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
          list = @specs[group].flatten.select { |f| f[0] == '-' }.map { |f| HelpParser.f2k(f) }
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
            @cache[variable] = @hash[key]
          else
            strings = Array(String).new
            strings.push @hash[key]
            loop do
              key = keys[i + 1_u8]?
              break unless key.is_a?(UInt8)
              strings.push @hash[key]
              i += 1_u8
            end
            @cache[variable] = strings
          end
        else # literal
          key = keys[i]?
          raise NoMatch.new if key.nil? || @hash[key] != token
        end
        i += 1_u8
      end
      return i
    end
  end
end
