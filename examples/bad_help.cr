require "json"
require "../src/help_parser"

def index
  ARGV[0].to_i
rescue Exception
  0
end

PN = File.basename(PROGRAM_NAME)

# duplicate in usage
HELP0 = <<-HELP
Usage:
  #{PN} [:options+] <args> <args>
  #{PN} [:options+] <args+>
Options:
  -n --number=NUMBER 1
Types:
  NUMBER /^\\d+$/
HELP

# spelling :optoins
HELP1 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:optoins+] <args>+
Options:
  -n --number=NUMBER 1
Types:
  NUMBER /^\\d+$/
HELP

# format <args+> instead of <args>+
HELP2 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:options+] <args+>
Options:
  -n --number=NUMBER 1
Types:
  NUMBER /^\\d+$/
HELP

# duplicate flag number
HELP3 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:options+] <args>+
Options:
  -n --number=NUMBER 1
  --number
Types:
  NUMBER /^\\d+$/
HELP

# default abc not NUMBER
HELP4 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:options+] <args>+
Options:
  -n --number=NUMBER abc
Types:
  NUMBER /^\\d+$/
HELP

# bad type spec
HELP5 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:options+] <args>+
Options:
  -n --number=NUMBER abc
Types:
  NUMBER ^\\d+$
HELP

# unbalaced
HELP6 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:options+] [<args>+
Options:
  -n --number=NUMBER 123
Types:
  NUMBER /^\\d+$/
HELP

# bad option spec
HELP7 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:options+] <args>+
Options:
  --n --number=NUMBER 123
Types:
  NUMBER /^\\d+$/
HELP

# unused Extra
HELP8 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:options+] <args>+
Options:
  -n --number=NUMBER 123
Extra:
  --extra
Types:
  NUMBER /^\\d+$/
HELP

# Extra cases not given
HELP9 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:extra+] <args>+
Options:
  -n --number=NUMBER 123
Extra:
Types:
  NUMBER /^\\d+$/
HELP

# extraneous spaces
HELP10 = <<-HELP
Usage:
  #{PN} [:options+] <arg1> <arg2>
  #{PN} [:extra+] <args>+
Options:
  -n --number=NUMBER 123
Extra:
  --extra
        \t
Types:
  NUMBER /^\\d+$/
HELP

# inconsitent arg1
HELP11 = <<-HELP
Usage:
  #{PN} [:options+] <arg1=PHONE> <arg2>
  #{PN} [:extra+] <arg1=NUMBER>
Options:
  -n --number=NUMBER 123
Extra:
  --extra
Types:
  NUMBER /^\\d+$/
  PHONE  /^\\d+-\\d+-\\d+$/
HELP

#
HELP12 = <<-HELP
Usage:
  #{PN} [:options+] <arg1=NUMBER> <arg2=PHONE>
  #{PN} [:extra+] <arg1=NUMBER>
Options:
  -n --number=NUMBER 123
Extra:
  --extra
Types:
  NUMBER /^\\d+$/
  PHONE  /^[]$/
HELP

#
HELP13 = <<-HELP
Usage:
  #{PN} [:options+] <arg1=EXTRA> <arg2=PHONE>
  #{PN} [:extra+] <arg1=EXTRA>
Options:
  -n --number=NUMBER 123
Extra:
  --extra
Types:
  NUMBER /^\\d+$/
  PHONE  /^\\d+-\\d+-\\d+$/
HELP

HELPS = [
  HELP0, HELP1, HELP2, HELP3, HELP4, HELP5,
  HELP6, HELP7, HELP8, HELP9, HELP10,
  HELP11, HELP12, HELP13
]

N = (ARGV.size>0)? ARGV[0].to_i : 0
OPTIONS = HelpParser["1.2.3", HELPS[index]]
puts OPTIONS._hash.to_json
