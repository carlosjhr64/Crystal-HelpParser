module HelpParser
  def self.parseh(help : String) : Hash(String, Array(Token))
    specs, name = Hash(String, Array(Token)).new, ""
    help.each_line do |line|
      next if line == ""
      if line =~ /^[A-Z]\w+:$/
        name = line[0..-2].downcase
        {% if !flag?(:release) %}
          raise HelpError.new(DUPLICATE_SECTION, name) if specs.has_key?(name)
        {% end %}
        specs[name] = Array(Token).new
      else
        next if name == ""
        break if line[0] == '#'
        next if !(line[0] == ' ')
        spec = (index = line.rindex('\t')) ? line[0, index].strip : line.strip
        HelpParser.validate_no_extraneous_spaces
        case name
        when USAGE
          chars = spec.chars
          HelpParser.validate_line_chars
          tokens = HelpParser.parseu(chars)
          HelpParser.validate_usage_tokens
          specs[name].push tokens
        when TYPES
          HelpParser.validate_type_spec
          specs[name].push spec.split.map { |s| s.as(Token) }
        when EXCLUSIVE
          HelpParser.validate_exclusive_pair
          specs[name].push spec.split.map { |s| s.as(Token) }
        else
          HelpParser.validate_option_spec
          specs[name].push spec.split.map { |s| s.as(Token) }
        end
      end
    end
    HelpParser.validate_usage_specs
    return specs
  end
end
