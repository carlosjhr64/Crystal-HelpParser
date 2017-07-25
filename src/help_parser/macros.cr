module HelpParser
  macro string(*names)
    module HelpParser
      class Options
        {% for name in names %}
          def {{name.id}} : String
            @hash["{{name.id}}"].as(String)
          rescue
            raise UsageError.new("{{name.id}} not a String.")
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
            raise UsageError.new("{{name.id}} not a String.")
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
            raise UsageError.new("{{name.id}} not Strings.")
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
            raise UsageError.new("{{name.id}} not Strings.")
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
            raise UsageError.new("{{name.id}} not a Float.")
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
            raise UsageError.new("{{name.id}} not a Float.")
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
            raise UsageError.new("{{name.id}} not Floats.")
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
            raise UsageError.new("{{name.id}} not Floats.")
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
            raise UsageError.new("{{name.id}} not an Integer.")
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
            raise UsageError.new("{{name.id}} not an Integer.")
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
            raise UsageError.new("{{name.id}} not Integers.")
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
            raise UsageError.new("{{name.id}} not Integers.")
          end
        {% end %}
      end
    end
  end
end
