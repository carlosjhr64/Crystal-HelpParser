module HelpParser
  class Options
    def initialize(
      version : String | Nil,
      help : String | Nil,
      argv : Array(String),
      @hash : ArgvHash = HelpParser.parsea(argv)
    )
      if version && (@hash.has_key?('v') || @hash.has_key?("version"))
        # -v or --version
        raise VersionException.new(version)
      end
      if help
        # -h or --help
        if @hash.has_key?('h') || @hash.has_key?("help")
          raise HelpException.new(help)
        end
        specs = HelpParser.parseh(help)
        Completion.new(@hash, specs)
        exclusive = specs[EXCLUSIVE]?
        unless exclusive.nil?
          exclusive.each { |xs| raise UsageError.new(EXCLUSIVE_KEYS, xs.as(Array(Token)).join(" ")) if @hash.keys.count { |k| xs.includes?(k.to_s) } > 1 }
        end
      end
    end

    def _hash
      @hash
    end

    def [](k)
      @hash[k]
    end

    def []?(k)
      @hash[k]?
    end

    def verbose? : Bool | Nil
      (@hash["verbose"]? == true) ? true : (@hash["quiet"]? == true) ? nil : false
    end

    def debug? : Bool
      @hash["debug"]? == true
    end
  end
end
