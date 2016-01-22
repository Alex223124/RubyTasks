require_relative 'MyHash.rb'

describe MyHash do
  let(:hash) { MyHash.new(1488) }
  before do
    10.times { |i| hash[i] = i }
  end

  describe "#[key]" do
    before { hash['key'] = 'value' }
    
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
    it "return length of 'hash'" do
      expect(hash.length).to eq 10
    end
  end

  describe "#eql?" do
    let(:otherhash) { MyHash.new }
    before do
      10.times { |i| otherhash[9 - i] = 9 - i }
    end

    it "return 'true' if hashes are equal" do
      expect(hash.eql?(otherhash)).to eq true
    end

    context "with change in our 'otherhash'" do
      before { otherhash[5] = 'value' }

      it "return 'false' if hashes are different" do
        expect(hash.eql?(otherhash)).to eq false
      end
    end
  end

  describe "#delete" do
    before { hash.delete(5) }

    it "delete pair key-value" do
      expect(hash.delete(5)).to eq 'There is no key in MyHash'
    end
  end

  describe "#values" do
    it "return array of values" do
      expect(hash.values).to eq (0..9).to_a
    end
  end

  describe "#keys" do
    it "return array of keys" do
      expect(hash.keys).to eq (0..9).to_a
    end
  end
end
