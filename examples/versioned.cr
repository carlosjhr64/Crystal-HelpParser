require "json"
require "../src/help_parser"

VERSION = "1.2.3"
OPTIONS = HelpParser[VERSION]
puts OPTIONS.hash!.to_json
