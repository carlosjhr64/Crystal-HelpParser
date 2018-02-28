module HelpParser
  USAGE = "usage"
  TYPES = "types"
  EXCLUSIVE = "exclusive"

  # usage
  FLAG       = /^[-][-]?(?<k>\w+)$/
  LITERAL    = /^(?<k>\w[\w.-]*:?)$/
  VARIABLE   = /^<(?<k>\w+)(=(?<t>[A-Z]+))?>(?<p>[+])?$/
  FLAG_GROUP = /^:(?<k>\w+)(?<p>[+])?$/

  # spec --?w+
  SHORT = /^[-](?<s>\w)$/
  LONG  = /^[-][-](?<k>\w+)(=(?<t>[A-Z]+))?(,?\s+(?<d>[^-\s]\S*))?$/

  # spec -w,? --w+
  SHORT_LONG         = /^[-](?<s>\w),?\s+[-][-](?<k>\w+)$/
  SHORT_LONG_DEFAULT = /^[-](?<s>\w),?\s+[-][-](?<k>\w+)(=(?<t>[A-Z]+))?,?\s+(?<d>[^-\s]\S*)$/

  # spec w+( w+)+
  X_DEF = /^\w+( +\w+)+$/

  # spec W+ /~/
  TYPE_DEF = /^(?<t>[A-Z]+),?\s+\/(?<r>\S+)\/$/

  CSV = /,?\s+/

  # exit codes
  EX_USAGE    = 64
  EX_SOFTWARE = 70
  EX_CONFIG   = 78

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

  NO_MATCH            = "Software Error: NoMatch was not caught by HelpParser."
  EXPECTED_TOKENS     = "Expected Tokens from @specs[USAGE]."
  MATCH_USAGE         = "Please match usage."
  EXTRANEOUS_SPACES   = "Extraneous spaces in help."
end
