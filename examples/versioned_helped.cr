require "json"
require "../src/help_parser"

VERSION = "1.2.3"

HELP = <<-HELP
### The Help ###
HELP

OPTIONS = HelpParser[VERSION, HELP]
puts OPTIONS.to_h.to_json
