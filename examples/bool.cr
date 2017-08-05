require "../src/help_parser"

HELP = <<-HELP
Options:
  -a
  --abc
HELP

HelpParser.sbool?(abc)
HelpParser.cbool?(a)

OPTIONS = HelpParser[help: HELP]
puts "-a: #{OPTIONS.a?}, --abc: #{OPTIONS.abc?}"
