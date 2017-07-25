require "./spec_helper"

describe "parseu" do
  it "parseu" do
    tokens = HelpParser.parseu("cmd [:options+] <args>+".chars)
    tokens.size.should eq 3
    tokens[1][0].should eq ":options+"
  end
end
