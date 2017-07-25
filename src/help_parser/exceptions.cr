module HelpParser
  class HelpParserException < Exception
    @code = 1

    # Must give message
    def initialize(message : String)
      super
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
    @code = 64 # EX_USAGE
  end

  class SoftwareError < HelpParserException
    # Stuff that should not happen
    @code = 70 # EX_SOFTWARE
  end

  class NoMatch < HelpParserException
    # used to shortcircuit out
    @code = 70 # EX_SOFTWARE

    # Forces it's owm message
    def initialize
      super("Software Error: NoMatch was not caught by HelpParser.")
    end
  end

  class HelpError < HelpParserException
    @code = 78 # EX_CONFIG
  end
end
