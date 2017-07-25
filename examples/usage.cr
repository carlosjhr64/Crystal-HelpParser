require "json"
require "../src/help_parser"

HELP = <<-HELP
Usage:
  crystal-run-usage.tmp a: <a>
  crystal-run-usage.tmp b: <b>
  crystal-run-usage.tmp c: <c>
HELP

OPTIONS = HelpParser[help: HELP]
puts OPTIONS._hash.to_json
