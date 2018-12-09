require "json"
require "../src/help_parser"

OPTIONS = HelpParser[]
puts OPTIONS.to_h.to_json
