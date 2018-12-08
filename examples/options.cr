require "json"
require "../src/help_parser"

HELP = <<-HELP
Options:
  -s           \t short
  --long       \t long
  -q --quiet   \t synonym
  --default ok \t default
  -w --wut WUT \t short default
HELP

OPTIONS = HelpParser[help: HELP]
puts OPTIONS.hash!.to_json
