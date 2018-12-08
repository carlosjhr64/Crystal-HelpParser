require "json"
require "../src/help_parser"

HELP = <<-HELP
Options:
  --float=FLOAT
  --number=NUMBER 123
  -n --name=NAME Guy
Types:
  FLOAT  /^\\d+\\.\\d+$/
  NUMBER /^\\d+$/
  NAME   /^[A-Z][a-z]+$/
HELP

OPTIONS = HelpParser[help: HELP]
puts OPTIONS.hash!.to_json
