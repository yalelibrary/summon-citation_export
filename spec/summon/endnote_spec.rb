require 'spec_helper'

describe Summon::Endnote do
  before do
    @search = Summon::Service.new(:transport => Summon::Transport::Canned.new).search
    @doc = @search.documents.first
  end
  it "extends summon document" do
    expect(@doc.to_endnote[:'%0']).to eq(['Newspaper Article'])
  end
  it "uses the 'Generic' for RT if no mapping is present" do
    @doc.stub(:content_type) {"Opaque"}
    expect(@doc.to_endnote[:'%0']).to eq(['Generic'])
  end

  it "primary title" do
    expect(@doc.to_endnote).to have_key(:'%T')
    expect(@doc.to_endnote[:'%T']).to eq(['OBITUARIES'])
  end

  it "author " do
    expect(@doc.to_endnote).to have_key(:'%A')
    expect(@doc.to_endnote[:'%A']).to eq(["Liang, Yong X, Gu, Miao N, Wang, Shi D, Chu, Hai C"])
  end

  describe "controlling how multiple values are concatenated" do
    before do
      @doc.stub(:multi_value) {[1,2,3]}
    end

    it "joins multiple values with ', ' by default" do
      expect(@doc.to_endnote(:multi_value => lambda {@doc.multi_value})[:multi_value]).to eql (["1, 2, 3"])
    end

    it "accepts the option to preserve multiple values per field" do
      expect(@doc.to_endnote(:multi_value => lambda {@doc.multi_value.tag_per_value})[:multi_value]).to eql ([1, 2, 3])
    end
  end
end
