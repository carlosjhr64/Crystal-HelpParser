require "./spec_helper"
# just some "Duh!" tests
describe "k2t2r" do
  it "k2t" do
    th = HelpParser::TokensHash.new
    k2t = HelpParser.k2t(th)
    k2t.size.should eq 0
    k2t.should be_a(HelpParser::StringHash)
  end

  it "t2r" do
    th = HelpParser::TokensHash.new
    t2r = HelpParser.t2r(th)
    t2r.should eq nil
  end
end
