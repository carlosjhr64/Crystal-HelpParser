require "../src/help_parser"

HELP = <<-HELP
The Awesome Command.
Usage:
  awesome [:options+] <args>+
  awesome :alternate <arg=NAME>
Options:
  -v --version       \t Give version and quit
  -h --help          \t Give help and quit
  -s --long          \t Short long synonyms
  --name=NAME        \t Typed
  --number 5         \t Defaulted
  --value=FLOAT 1.23 \t Typed and Defaulted
  -a --all=YN y      \t Short, long, typed, and defaulted
  -b
  --bool
Alternate:
  -V                 \t Just short
Types:
  NAME  /^[A-Z][a-z]+$/
  FLOAT /^\\d+\\.\\d+$/
  YN    /^[YNyn]$/
HELP

VERSION = "5.1.1"

# Macros:
HelpParser.string(name)  # for options.name   : String
HelpParser.strings(args) # for options.args   : Array(String)
HelpParser.float(value)  # for options.value  : Float
HelpParser.int?(number)  # for options.number : Int32 | Nil
HelpParser.sbool?(bool)  # for options.bool?  : Bool
HelpParser.cbool?(b)     # for options.b?     : Bool

HelpParser.new(VERSION, HELP, ["awesome"]+ARGV) do |options|
  hash = options._hash
  pp hash # to inspect the hash

  pp options.name  if hash["name"]?
  pp options.args  if hash["args"]?
  pp options.value if hash["value"]?
  pp options.number?
  pp options.bool?
  pp options.b?
end
