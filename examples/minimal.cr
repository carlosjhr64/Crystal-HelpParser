require "json"
require "../src/help_parser"

OPTIONS = HelpParser[]
puts OPTIONS._hash.to_json
