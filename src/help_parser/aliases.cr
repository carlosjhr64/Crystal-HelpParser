module HelpParser
  alias Token = String | Array(Token)
  alias TokensHash = Hash(String, Array(Token))

  class ArgvHash < Hash(UInt8 | Char | String, Bool | String | Array(String))
    private macro nodupkey(k)
      # No duplicate keys allowed in argv
      raise UsageError.new(DUPLICATE_KEY, {{k.id}} ) if self.has_key?( {{k.id}} )
    end

    # UInt8 => String
    def []=(k : UInt8, v : String)
      nodupkey(k)
      super
    end

    # UInt8 => String
    def [](k : UInt8) : String
      super.as(String)
    end

    # Char => Bool
    def []=(k : Char, v : Bool)
      nodupkey(k)
      super
    end

    # Char => Bool
    def [](k : Char) : Bool
      super.as(Bool)
    end

    # String => Bool
    def []=(k : String, v : Bool)
      nodupkey(k)
      super
    end

    # String => String
    def []=(k : String, v : String)
      nodupkey(k)
      super
    end

    # String => Array(String)
    def []=(k : String, v : Array(String))
      nodupkey(k)
      super
    end

    # String => Bool | String | Array(String)
    def [](k : String)
      super.as(Bool | String | Array(String))
    end

    def []=(k, v)
      raise SoftwareError.new(UNRECOGNIZED_MAPPING, k, v)
    end

    def [](k)
      raise SoftwareError.new(UNRECOGNIZED_KEY, k)
    end
  end

  macro f2k(f)
    ({{f.id}}[1]=='-')? {{f.id}}[2..(({{f.id}}.index('=')||0)-1)] : {{f.id}}[1]
  end

  macro f2s(f)
    ({{f.id}}[1]=='-')? {{f.id}}[2..(({{f.id}}.index('=')||0)-1)] : {{f.id}}.lchop
  end

  macro reserved(k)
    [USAGE,TYPES,EXCLUSIVE].includes?({{k.id}})
  end
end
