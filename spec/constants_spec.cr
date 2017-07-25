require "./spec_helper"

describe "string" do
  it "equals" do
    HelpParser::USAGE.should eq "usage"
    HelpParser::TYPES.should eq "types"
  end
end

describe "regexp" do
  it "matches" do
    HelpParser::FLAG.should match "--flag"
    if md = HelpParser::FLAG.match "--flag"
      md[1].should eq "flag"
    end

    HelpParser::LITERAL.should match "a-b.c:"
    if md = HelpParser::LITERAL.match "a-b.c:"
      md[1].should eq "a-b.c:"
    end

    HelpParser::VARIABLE.should match "<abc=ABC>+"
    if md = HelpParser::VARIABLE.match "<abc=ABC>+"
      md[1].should eq "abc"
    end

    HelpParser::FLAG_GROUP.should match ":abc+"
    if md = HelpParser::VARIABLE.match ":abc+"
      md[1].should eq "abc"
    end

    HelpParser::SHORT.should match "-f"
    HelpParser::LONG.should match "--flag"
    HelpParser::SHORT_LONG.should match "-f --flag"
    HelpParser::SHORT_LONG_DEFAULT.should match "-f --flag=FLAG Flag"
    HelpParser::TYPE_DEF.should match "ABC /abc/"
  end

  it "splits" do
    l = "a, b c  d".split(HelpParser::CSV)
    l.should eq ["a","b","c","d"]
  end
end
