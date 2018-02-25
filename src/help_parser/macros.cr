module HelpParser
  macro string(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}} : String
            @hash["{{name.id}}"].as(String)
          rescue
            raise UsageError.new(NOT_STRING, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro string?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : String | Nil
            @hash["{{name.id}}"]?.as(String | Nil)
          rescue
            raise UsageError.new(NOT_STRING, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro strings(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}} : Strings
            @hash["{{name.id}}"].as(Strings)
          rescue
            raise UsageError.new(NOT_STRINGS, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro strings?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : Strings | Nil
            @hash["{{name.id}}"]?.as(Strings | Nil)
          rescue
            raise UsageError.new(NOT_STRINGS, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro float(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}} : Float64
            @hash["{{name.id}}"].as(String).to_f
          rescue
            raise UsageError.new(NOT_FLOAT, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro float?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : Float64 | Nil
            a = @hash["{{name.id}}"]?
            a ? a.as(String).to_f : nil
          rescue
            raise UsageError.new(NOT_FLOAT, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro floats(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}} : Array(Float64)
            @hash["{{name.id}}"].as(Strings).map{|v|v.as(String).to_f}
          rescue
            raise UsageError.new(NOT_FLOATS, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro floats?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : Array(Float64) | Nil
            a = @hash["{{name.id}}"]?
            a ? a.as(Strings).map{|v|v.as(String).to_f} : nil
          rescue
            raise UsageError.new(NOT_FLOATS, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro int(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}} : Int32
            @hash["{{name.id}}"]?.as(String).to_i
          rescue
            raise UsageError.new(NOT_INTEGER, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro int?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : Int32 | Nil
            a = @hash["{{name.id}}"]?
            a ? a.as(String).to_i : nil
          rescue
            raise UsageError.new(NOT_INTEGER, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro ints(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}} : Array(Int32)
            @hash["{{name.id}}"].as(Strings).map{|v|v.as(String).to_i}
          rescue
            raise UsageError.new(NOT_INTEGERS, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro ints?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : Array(Int32) | Nil
            a = @hash["{{name.id}}"]?
            a ? a.as(Strings).map{|v|v.as(String).to_i} : nil
          rescue
            raise UsageError.new(NOT_INTEGERS, "{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro sbool?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : Bool
            @hash.has_key?("{{name.id}}")
          end
        {% end %}
      end
    end
  end

  macro cbool?(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}}? : Bool
            @hash.has_key?('{{name.id}}')
          end
        {% end %}
      end
    end
  end
end
