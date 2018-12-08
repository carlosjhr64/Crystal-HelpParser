require "json"
require "../src/help_parser"

HELP = <<-HELP
### The Help ###
Usage:
  #{File.basename(PROGRAM_NAME)} [:options+]
Options:
  -a
  -b
  -c
  -d
  -e
Exclusive:
  a b
  c d e
# Breaks out!
  cacahuates
HELP

VERSION = "1.0.0"

OPTIONS = HelpParser[VERSION, HELP]
puts OPTIONS.hash!.to_json
