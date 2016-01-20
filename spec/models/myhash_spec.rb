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

  describe "#length" do
    let(:hash) { MyHash.new }
    before do
      100.times { |i| hash[i] = i } 
    end

    it "return length of MyHash" do
      expect(hash.length).to eq 100
    end
  end

  describe "#eql?" do
    let(:hash) { MyHash.new }
    let(:otherhash) { MyHash.new }
    before do
      100.times do |i|
        hash[i] = i
        otherhash[99 - i] = 99 - i
      end
    end

    it "return 'true' if hashes are equal" do
      expect(hash.eql?(otherhash)).should be_true
    end

    before { otherhash['key'] = 'value' }
    it "return 'false' if hashes are different" do
      expect(hash.eql?(otherhash)).should be_false
    end
  end
end
