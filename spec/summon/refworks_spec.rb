require 'spec_helper'

describe Summon::Refworks do
  before do
    @search = Summon::Service.new(:transport => Summon::Transport::Canned.new).search
    @doc = @search.documents.first
  end
  it "extends summon document" do
    @doc.to_refworks.should include(:RT => ["Newspaper Article"])
  end
  it "uses the 'Generic' for RT if no mapping is present" do
    @doc.stub(:content_type) {"Opaque"}
    @doc.to_refworks[:RT].should eql ['Generic']
  end

  describe "controlling how multiple values are concatenated" do
    before do
      @doc.stub(:multi_value) {[1,2,3]}
    end

    it "joins multiple values with ', ' by default" do
      @doc.to_refworks(:multi_value => lambda {@doc.multi_value})[:multi_value].should eql ["1, 2, 3"]
    end

    it "accepts the option to preseve multiple values per field" do
      @doc.to_refworks(:multi_value => lambda {@doc.multi_value.tag_per_value})[:multi_value].should eql [1,2,3]
    end
  end
end
