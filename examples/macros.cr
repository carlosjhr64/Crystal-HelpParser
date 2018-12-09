require "../src/help_parser"

HELP = <<-HELP
Usage:
  cmd :options+ <pet> <more>+
  cmd ints <many>+
  cmd floats <much>+
Options:
  --age
  --weight
HELP

HelpParser.string?(pet)
HelpParser.string(pet)

HelpParser.float?(weight)
HelpParser.float(weight)

HelpParser.int?(age)
HelpParser.int(age)

HelpParser.strings(more)
HelpParser.strings?(more)

HelpParser.floats(much)
HelpParser.floats?(much)

HelpParser.ints(many)
HelpParser.ints?(many)

OPTIONS = HelpParser[
  help: HELP,
  argv: ["cmd"]+ARGV
]

if OPTIONS.pet?
  puts "Pet: #{OPTIONS.pet} Age: #{OPTIONS.age} Weight: #{OPTIONS.weight} More: #{OPTIONS.more.join(",")}"
elsif OPTIONS.many?
  puts "Many Total: #{OPTIONS.many.sum}"
elsif OPTIONS.much?
  puts "Much Total: #{OPTIONS.much.sum}"
else
  puts OPTIONS.to_h
end
