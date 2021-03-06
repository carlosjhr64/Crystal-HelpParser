require "./help_parser/constants"
require "./help_parser/exceptions"
require "./help_parser/aliases"
require "./help_parser/validations"
require "./help_parser/parseu"
require "./help_parser/parseh"
require "./help_parser/k2t2r"
require "./help_parser/completion"
require "./help_parser/options"
require "./help_parser/macros"

module HelpParser
  VERSION = "8.0.0"

  def self.[](
    version : String? = nil,
    help : String? = nil,
    argv : Array(String) = [File.basename(PROGRAM_NAME)] + ARGV
  )
    Options.new(version, help, argv)
  rescue exception : HelpParserException
    exception.exit
  end

  def self.run(
    version : String? = nil,
    help : String? = nil,
    argv : Array(String) = [File.basename(PROGRAM_NAME)] + ARGV
  )
    yield Options.new(version, help, argv)
  rescue exception : HelpParserException
    exception.exit
  end
end
