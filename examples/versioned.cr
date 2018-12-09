require "json"
require "../src/help_parser"

VERSION = "1.2.3"
OPTIONS = HelpParser[VERSION]
puts OPTIONS.to_h.to_json
