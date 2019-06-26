require 'spec_helper'

describe Summon::Ris do
  before do
    @search = Summon::Service.new(:transport => Summon::Transport::Canned.new).search
    @doc = @search.documents.first
  end
  it "extends summon document" do
    expect(@doc.to_ris[:'TY  -']).to eq(['NEWS'])
  end
  it "uses the 'Generic' for TY if no mapping is present" do
    @doc.stub(:content_type) {"Opaque"}
    expect(@doc.to_ris[:'TY  -']).to eq(['GEN'])
  end
  it "ER is presented in the hash" do
    expect(@doc.to_ris).to have_key(:'ER  -')
  end

  describe "controlling how multiple values are concatenated" do
    before do
      @doc.stub(:multi_value) {[1,2,3]}
    end

    it "joins multiple values with '; ' by default" do
      #@doc.to_ris(:multi_value => lambda {@doc.multi_value})[:multi_value].should eql ["1; 2; 3"]
      expect(@doc.to_ris(:multi_value => lambda {@doc.multi_value})[:multi_value]).to eql (["1; 2; 3"])
    end

    it "accepts the option to preseve multiple values per field" do
      #@doc.to_ris(:multi_value => lambda {@doc.multi_value.tag_per_value})[:multi_value].should eql [1,2,3]
      expect(@doc.to_ris(:multi_value => lambda {@doc.multi_value.tag_per_value})[:multi_value]).to eql ([1, 2, 3])
    end
  end
end
