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

  # exit codes
  EX_USAGE    = 64
  EX_SOFTWARE = 70
  EX_CONFIG   = 78

  # error messages, partials:
  DUPLICATE_KEY                  = "Duplicate key"
  DUPLICATE_WORD                 = "Duplicate word"
  DUPLICATE_FLAG                 = "Duplicate flag"
  DUPLICATE_SECTION              = "Duplicate section"
  DUPLICATE_EXCLUSIVE_SPEC       = "Duplicate exclusive spec"
  UNDEFINED_FLAG                 = "Undefined flag"
  INCONSISTENT_USE_OF_VARIABLE   = "Inconsistent use of variable"
  UNEXPECTED_STRING_IN_HELP_TEXT = "Unexpected string in help text"
  BAD_REGEX                      = "Bad regex"
  REDUNDANT                      = "Redundant"
  EXCLUSIVE_KEYS                 = "Exclusive keys"
  UNBALANCED_BRACKETS            = "Unbalanced brackets"
  UNRECOGNIZED_KEY               = "Unrecognized key"
  UNRECOGNIZED_MAPPING           = "Unrecognized mapping"
  UNRECOGNIZED_USAGE_TOKEN       = "Unrecognized usage token"
  UNRECOGNIZED_TYPE_SPEC         = "Unrecognized type spec"
  UNRECOGNIZED_EXCLUSIVE_SPEC    = "Unrecognized exclusive spec"
  UNRECOGNIZED_OPTION_SPEC       = "Unrecognized option spec"
  UNRECOGNIZED                   = "Unrecognized"
  SECTION_NOT_DEFINED            = "Section not defined"
  MISSING_CASES                  = "Missing cases"
  MISSING_USAGE                  = "Missing usage"
  UNCOMPLETED_TYPES_DEFINITION   = "Uncompleted types definition"
  DEFAULT_DOES_NOT_MATCH_TYPE    = "Default does not match type"
  NOT_A_STRING                   = "Not a String"
  NOT_ALL_STRINGS                = "Not all Strings"
  NOT_A_FLOAT                    = "Not a Float"
  NOT_ALL_FLOATS                 = "Not all Floats"
  NOT_AN_INTEGER                 = "Not an Integer"
  NOT_ALL_INTEGERS               = "Not all Integers"

  # error messages, full:
  NO_MATCH          = "Software Error: NoMatch was not caught by HelpParser."
  MATCH_USAGE       = "Please match usage."
  EXTRANEOUS_SPACES = "Extraneous spaces in help."
  EXPECTED_TOKENS   = "Expected Tokens from @specs[USAGE]."
end
