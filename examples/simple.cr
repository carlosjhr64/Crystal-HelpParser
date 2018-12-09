require "json"
require "../src/help_parser"

HELP = <<-HELP
### The Help ###
Usage:
  #{File.basename(PROGRAM_NAME)} [:options+] [<args>+]
Options:
  -s --long
  -n --number=NUMBER 1
Types:
  NUMBER /^\\d+$/
HELP

VERSION = "1.0.0"

OPTIONS = HelpParser[VERSION, HELP]
puts OPTIONS.to_h.to_json
