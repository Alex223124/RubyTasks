require '/home/dima/RubyTasks/MyHash.rb'

describe MyHash do
  describe "#[key]" do
    let(:hash) { MyHash.new }
    before do
      hash['key'] = 'value' 
    end
    it "return 'value'" do
      expect(hash['key']).to eq 'value'
    end
  end
end
