require "json"
require "../src/help_parser"

HELP = <<-HELP
### The Help ###
Usage:
  #{File.basename(PROGRAM_NAME)} :options+
  #{File.basename(PROGRAM_NAME)} :alternate+ <string>
Options:
  -a --abc
  -x --xyz
Alternate:
  -n --number
  -m --amount
HELP

VERSION = "1.0.0"

OPTIONS = HelpParser[VERSION, HELP]
puts OPTIONS.to_h.to_json
