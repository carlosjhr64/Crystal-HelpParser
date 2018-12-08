require "json"
require "../src/help_parser"

OPTIONS = HelpParser[]
puts OPTIONS.hash!.to_json
