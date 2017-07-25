module HelpParser
  def self.parseh(help : String) : TokensHash
    specs,name = TokensHash.new,""
    help.each_line do |line|
      next if line==""
      if line=~/^[A-Z]\w+:$/
        name = line[0..-2].downcase
        specs[name] = Tokens.new
      else
        next if name=="" || !(line[0]==' ')
        spec = (index=line.rindex('\t'))? line[0,index].strip : line.strip
        HelpParser.validate_no_extraneous_spaces
        if name==USAGE
          HelpParser.validate_usage_spec
          specs[name].push HelpParser.parseu spec
        elsif name==TYPES
          HelpParser.validate_type_spec
          specs[name].push spec.split(CSV).map{|s| s.as(Token)}
        else
          HelpParser.validate_option_spec
          specs[name].push spec.split(CSV).map{|s| s.as(Token)}
        end
      end
    end
    HelpParser.validate_usage_specs
    return specs
  end
end
