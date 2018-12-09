module HelpParser
  alias Token = String | Array(Token)
  alias ArgvKey = UInt8 | Char | String
  alias ArgvValue = Bool | String | Array(String)
  alias ArgvHash = Hash(ArgvKey, ArgvValue)

  macro reserved(k)
    [USAGE, TYPES, EXCLUSIVE].includes?({{k.id}})
  end
end
