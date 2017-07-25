module HelpParser
  class Options
    def initialize(
      version : String | Nil,
      help    : String | Nil,
      argv    : Array(String),
      @hash   : ArgvHash = HelpParser.parsea(argv))
      if version && (@hash.has_key?('v') || @hash.has_key?("version"))
        # -v or --version
        raise VersionException.new(version)
      end
      if help
        if @hash.has_key?('h') || @hash.has_key?("help")
          # -h or --help
          raise HelpException.new(help)
        end
        specs = HelpParser.parseh(help)
        Completion.new(@hash, specs)
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
  end
end
