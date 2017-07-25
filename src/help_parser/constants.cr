module HelpParser
  USAGE = "usage"
  TYPES = "types"

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

  # spec W+ /~/
  TYPE_DEF = /^(?<t>[A-Z]+),?\s+\/(?<r>\S+)\/$/

  CSV = /,?\s+/
end
