private macro hash_class(name, key, value)
  class {{name.id}} < Hash({{key.id}}, {{value.id}})
    def []=(k : {{key.id}}, v : {{value.id}})
      {% if !flag?(:release) %}
        raise HelpError.new(DUP_KEY,k) if self.has_key?(k)
      {% end %}
      super
    end

    def []=(k, v)
      raise SoftwareError.new(UNRECOGNIZED_MAP, k, v)
    end
  end
end

module HelpParser
  alias Chars        = Array(Char)
  alias Token        = String | Array(Token)
  alias Tokens       = Array(Token)
  alias Strings      = Array(String)
  alias Stringer     = String | Strings
  alias ArgvKey      = String | Char | UInt8
  alias ArgvValue    = Bool | Stringer

  hash_class( TokensHash,    String, Tokens   )
  hash_class( StringHash,    String, String   )
  hash_class( RegexHash,     String, Regex    )
  hash_class( StringerHash,  String, Stringer )

  class ArgvHash < Hash(ArgvKey, ArgvValue)
    private macro nodupkey(k) # No duplicate keys allowed in argv
      raise UsageError.new(DUP_KEY, {{k.id}} ) if self.has_key?( {{k.id}} )
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
    # String => ArgvValue
    def [](k : String)
      super.as(ArgvValue)
    end

    def []=(k, v)
      raise SoftwareError.new(UNRECOGNIZED_MAP, k, v)
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
end
