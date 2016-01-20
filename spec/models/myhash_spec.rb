require '/home/dima/RubyTasks/MyHash.rb'

describe MyHash do
  describe "#[key]" do
    let(:hash) { MyHash.new(1488) }
    before do
      10.times { |i| hash[i] = i }
      hash['key'] = 'value' 
    end

    it "return 'value'" do
      expect(hash['key']).to eq 'value'
    end

	it "return 'default' value" do
      expect(hash[123]).to eq 1488
	end   

	context "when add many pairs key-value" do
	  before do 
	    hash.clear 
	    hash.add_many(:a, 1, :b, 2, :c, 3, :a, 14, :a, 15, :b)
	  end
	  it "return 'hash' with values" do
        expect(hash.to_s).to eq "{a => 15, b => 1488, c => 3, }"
      end
	end
  end

  describe "#length" do
    let(:hash) { MyHash.new }
    before do
      100.times { |i| hash[i] = i } 
    end

    it "return length of 'hash'" do
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
      expect(hash.eql?(otherhash)).to eq true
    end
    
    context "with change in our 'otherhash'" do
      before { otherhash[50] = 'value' }

      it "return 'false' if hashes are different" do
        expect(hash.eql?(otherhash)).to eq false
      end
    end
  end

  describe "#delete" do
    let(:hash) { MyHash.new }
    before do
      10.times { |i| hash[i] = i}
      hash.delete(5)
    end

    it "delete pair key-value" do
      expect(hash.delete(5)).to eq 'There is no key in MyHash'
    end
  end

  describe "#values and #keys" do
    let(:hash) { MyHash.new }
    before do
      10.times { |i| hash[i] = i}
    end

    it "return array of values" do
      expect(hash.values).to eq (0..9).to_a
    end

    it "return array of keys" do
      expect(hash.keys).to eq (0..9).to_a
    end
  end
end
