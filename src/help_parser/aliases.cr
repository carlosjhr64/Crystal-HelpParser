module HelpParser
  alias Token = String | Array(Token)
  alias ArgvKey = UInt8 | Char | String
  alias ArgvValue = Bool | String | Array(String)
  alias ArgvHash = Hash(ArgvKey, ArgvValue)

  macro f2k(f)
    ({{f.id}}[1]=='-')? {{f.id}}[2..(({{f.id}}.index('=')||0)-1)] : {{f.id}}[1]
  end

  macro f2s(f)
    ({{f.id}}[1]=='-')? {{f.id}}[2..(({{f.id}}.index('=')||0)-1)] : {{f.id}}.lchop
  end

  macro reserved(k)
    [USAGE, TYPES, EXCLUSIVE].includes?({{k.id}})
  end
end
