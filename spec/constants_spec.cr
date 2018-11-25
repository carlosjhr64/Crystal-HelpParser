require "./spec_helper"

describe "string" do
  it "equals" do
    HelpParser::USAGE.should eq "usage"
    HelpParser::TYPES.should eq "types"
  end
end

describe "regexp" do
  it "matches" do
    HelpParser::USAGE_FLAG_PATTERN.should match "--flag"
    if md = HelpParser::USAGE_FLAG_PATTERN.match "--flag"
      md[1].should eq "flag"
    end

    HelpParser::USAGE_LITERAL_PATTERN.should match "a-b.c:"
    if md = HelpParser::USAGE_LITERAL_PATTERN.match "a-b.c:"
      md[1].should eq "a-b.c:"
    end

    HelpParser::USAGE_VARIABLE_PATTERN.should match "<abc=ABC>+"
    if md = HelpParser::USAGE_VARIABLE_PATTERN.match "<abc=ABC>+"
      md[1].should eq "abc"
    end

    HelpParser::USAGE_FLAG_GROUP_PATTERN.should match ":abc+"
    if md = HelpParser::USAGE_VARIABLE_PATTERN.match ":abc+"
      md[1].should eq "abc"
    end

    HelpParser::SPEC_SHORT_PATTERN.should match "-f"
    HelpParser::SPEC_LONG_PATTERN.should match "--flag"
    HelpParser::SPEC_SHORT_LONG_PATTERN.should match "-f --flag"
    HelpParser::SPEC_SHORT_LONG_DEFAULT_PATTERN.should match "-f --flag=FLAG Flag"
    HelpParser::SPEC_TYPE_DEFINITION_PATTERN.should match "ABC /abc/"
  end
end
