module HelpParser
  class Options
    private macro set(k, v)
      raise UsageError.new(DUPLICATE_KEY, {{k.id}} ) if @hash.has_key?( {{k.id}} )
      @hash[{{k.id}}] = {{v.id}}
    end

    def initialize(
      version : String?,
      help : String?,
      argv : Array(String),
    )

      @hash = ArgvHash.new
      n = 0_u8
      argv.each do |a|
        if a[0] == '-'
          break if a.size == 1 # "-" quits argv processing
          if a[1] == '-'
            break if a.size == 2 # "--" also quits argv processing
            s = a[2..-1]
            if s.includes?('=')
              k, v = s.split('=', 2)
              self[k] = v
            else
              self[s] = true
            end
          else
            a.chars[1..-1].each do |c|
              self[c] = true
            end
          end
        else
          self[n] = a
          n += 1_u8
        end
      end

      if version && (@hash.has_key?('v') || @hash.has_key?("version"))
        # -v or --version
        raise VersionException.new(version)
      end

      if help
        # -h or --help
        if @hash.has_key?('h') || @hash.has_key?("help")
          raise HelpException.new(help)
        end
        Completion.new(self, HelpParser.parseh(help))
      end
    end

    # UInt8 => String
    def []=(k : UInt8, v : String)
      set(k, v)
    end
    def [](k : UInt8) : String
      @hash[k].as(String)
    end
    def []?(k : UInt8) : String?
      @hash[k]?.as(String?)
    end

    # Char => Bool
    def []=(k : Char, v : Bool)
      set(k, v)
    end
    def [](k : Char) : Bool
      @hash[k].as(Bool)
    end
    def []?(k : Char) : Bool?
      @hash[k].as(Bool?)
    end

    # String => ArgvValue
    def []=(k : String, v : Bool)
      set(k, v)
    end
    def []=(k : String, v : String)
      set(k, v)
    end
    def []=(k : String, v : Array(String))
      set(k, v)
    end
    def [](k : String) : ArgvValue
      @hash[k]
    end
    def []?(k : String) : ArgvValue?
      @hash[k]?
    end

    def verbose? : Bool?
      (@hash["verbose"]? == true) ? true : (@hash["quiet"]? == true) ? nil : false
    end

    def debug? : Bool
      @hash["debug"]? == true
    end

    def to_h
      @hash
    end
  end
end
