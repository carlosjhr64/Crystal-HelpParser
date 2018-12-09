require "json"
require "../src/help_parser"

HELP = <<-HELP
### The Help ###
HELP

OPTIONS = HelpParser[help: HELP]
puts OPTIONS.to_h.to_json
