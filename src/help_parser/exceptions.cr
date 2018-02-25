module HelpParser
  class HelpParserException < Exception
    @code = 1

    # Must give message
    def initialize(message : String, *keys)
      keys.size==0 ? super(message) : super("#{message}:  #{keys.join(" ")}")
    end

    def exit
      if @code > 0
        STDERR.puts self.message
      else
        puts self.message
      end
      exit @code
    end
  end

  class VersionException < HelpParserException
    @code = 0
  end

  class HelpException < HelpParserException
    @code = 0
  end

  class UsageError < HelpParserException
    @code = EX_USAGE
  end

  class SoftwareError < HelpParserException
    # Stuff that should not happen
    @code = EX_SOFTWARE
  end

  class NoMatch < HelpParserException
    # used to shortcircuit out
    @code = EX_SOFTWARE

    # Forces it's owm message
    def initialize
      super(NO_MATCH)
    end
  end

  class HelpError < HelpParserException
    @code = EX_CONFIG
  end
end
