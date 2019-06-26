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

end
