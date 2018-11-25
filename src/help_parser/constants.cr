module HelpParser
  USAGE     = "usage"
  TYPES     = "types"
  EXCLUSIVE = "exclusive"

  # usage
  USAGE_FLAG_PATTERN       = /^[-][-]?(?<k>\w+)$/
  USAGE_LITERAL_PATTERN    = /^(?<k>\w[\w.-]*:?)$/
  USAGE_VARIABLE_PATTERN   = /^<(?<k>\w+)(=(?<t>[A-Z]+))?>(?<p>[+])?$/
  USAGE_FLAG_GROUP_PATTERN = /^:(?<k>\w+)(?<p>[+])?$/

  # spec --?w+
  SPEC_SHORT_PATTERN = /^[-](?<s>\w)$/
  SPEC_LONG_PATTERN  = /^[-][-](?<k>\w+)(=(?<t>[A-Z]+))?(,?\s+(?<d>[^-\s]\S*))?$/

  # spec -w,? --w+
  SPEC_SHORT_LONG_PATTERN         = /^[-](?<s>\w),?\s+[-][-](?<k>\w+)$/
  SPEC_SHORT_LONG_DEFAULT_PATTERN = /^[-](?<s>\w),?\s+[-][-](?<k>\w+)(=(?<t>[A-Z]+))?,?\s+(?<d>[^-\s]\S*)$/

  # spec W+ /~/
  SPEC_TYPE_DEFINITION_PATTERN = /^(?<t>[A-Z]+),?\s+\/(?<r>\S+)\/$/

  # spec w+( w+)+
  SPEC_EXCLUSIVE_PAIR_PATTERN = /^\w+( +\w+)+$/

  CSV = /,?\s+/

  # exit codes
  EX_USAGE    = 64
  EX_SOFTWARE = 70
  EX_CONFIG   = 78

  # error messages, partials:
  DUP_KEY             = "Duplicate key"
  DUP_WORD            = "Duplicate word"
  DUP_FLAG            = "Duplicate flag"
  DUP_X               = "Duplicate exclusive spec"
  UNSEEN_FLAG         = "Undefined flag"
  INCONSISTENT        = "Inconsistent use of variable"
  UNEXPECTED          = "Unexpected string in help text"
  BAD_REGEX           = "Bad regex"
  REDUNDANT           = "Redundant"
  EXCLUSIVE_KEYS      = "Exclusive keys"
  UNBALANCED          = "Unbalanced brackets"
  UNRECOGNIZED_KEY    = "Unrecognized key"
  UNRECOGNIZED_MAP    = "Unrecognized mapping"
  UNRECOGNIZED_TOKEN  = "Unrecognized usage token"
  UNRECOGNIZED_TYPE   = "Unrecognized type spec"
  UNRECOGNIZED_X      = "Unrecognized exclusive spec"
  UNRECOGNIZED_OPTION = "Unrecognized option spec"
  UNRECOGNIZED        = "Unrecognized"
  UNDEFINED_SECTION   = "Section not defined"
  MISSING_CASES       = "Missing cases"
  MISSING_USAGE       = "Missing usage"
  UNCOMPLETED_TYPES   = "Uncompleted types definition"
  BAD_DEFAULT         = "Default does not match type"
  NOT_STRING          = "Not a String"
  NOT_STRINGS         = "Not all Strings"
  NOT_FLOAT           = "Not a Float"
  NOT_FLOATS          = "Not all Floats"
  NOT_INTEGER         = "Not an Integer"
  NOT_INTEGERS        = "Not all Integers"
  # error messages, full:
  NO_MATCH          = "Software Error: NoMatch was not caught by HelpParser."
  MATCH_USAGE       = "Please match usage."
  EXTRANEOUS_SPACES = "Extraneous spaces in help."
  EXPECTED_TOKENS   = "Expected Tokens from @specs[USAGE]."
end
