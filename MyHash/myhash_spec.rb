require_relative 'MyHash.rb'
include Version2

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
  end

  describe "#add_many(key1, value1, key2, value2, ...)" do
    let(:otherhash) { MyHash.new }
    before do
      hash.clear
      hash.add_many(:a, 1, :b, 2, :c, 3, :a, 14, :a, 15)
      otherhash[:a] = 15
      otherhash[:b] = 2
      otherhash[:c] = 3
    end

    it "return 'hash' with values" do
      expect(hash.eql?(otherhash)).to eq true
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

    it "return 'false' if argument isn't instance of MyHash" do
      expect(hash.eql?([])).to eq false
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

  describe "#clear" do
    it "return clear 'hash'" do
      expect(hash.clear).to eq []
    end
  end

  describe "#empty?" do
    it "return 'false' if there is something in 'hash'" do
      expect(hash.empty?).to eq false
    end

    it "return 'true' if 'hash' is empty" do
      expect(hash.clear.empty?).to eq true
    end
  end
end
