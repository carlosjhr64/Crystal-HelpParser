require "./spec_helper"

describe "parsea" do
  it "quits processing on one" do
    hsh = HelpParser.parsea(["-a","-b","-c","-","-d","-e","-f"])
    hsh.size.should eq 3
    hsh['a'].should be_true
    hsh['b'].should be_true
    hsh['c'].should be_true
    hsh.has_key?('d').should be_false
  end

  it "quits processing on two" do
    hsh = HelpParser.parsea(["--a","--b","--c","--","--d","--e","--f"])
    hsh.size.should eq 3
    hsh["a"].should be_true
    hsh["b"].should be_true
    hsh["c"].should be_true
    hsh.has_key?("d").should be_false
  end

  it "should set value" do
    hsh = HelpParser.parsea(["--abc=xyz"])
    hsh["abc"].should eq("xyz")
  end

  it "should set variable" do
    hsh = HelpParser.parsea(["a","bc"])
    hsh[0_u8].should eq "a"
    hsh[1_u8].should eq "bc"
  end

  it "is_a" do
    hsh = HelpParser.parsea(["cmd","-a","--bc","--x=4","file"])
    hsh.is_a?(HelpParser::ArgvHash).should be_true
    hsh[0_u8].should eq "cmd"
    hsh['a'].should be_true
    hsh["bc"].should be_true
    hsh["x"].should eq "4"
  end
end
