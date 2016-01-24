Pair = Struct.new(:key, :value)

class MyHash

  def initialize(default = nil)
    @main_array = []
    @const = 50000
    @default = default
    @size = 0
  end

  def hash_func(key)
    key.hash % @const
  end

  def []=(key, value)
    pair = Pair.new(key, value)
    index = hash_func(key)
    @main_array[index] ||= []
    if @main_array[index].empty?
      @main_array[index] << pair
      
    else
      @main_array[index].each { |p| return p = pair if p.key == pair.key }
      @main_array[index] << pair
    end
    @size += 1
  end

  def [](key)
    index = hash_func(key)
    if @main_array[index].nil?
      @default
    else
      @main_array[index].each { |pair| return pair.value if pair.key == key }
    end
    @default
  end

  def length
    @size
  end

  def clear
    @main_array.clear
  end

  def empty?
    @main_array.empty? ? true : false
  end

  def keys
    key_array = []
    @main_array.each do |arr|
      arr.each { |pair| key_array << pair.key } unless arr.nil?
    end
    key_array.sort
  end

  def values
    value_array = []
    @main_array.each do |arr|
      arr.each { |pair| value_array << pair.value } unless arr.nil?
    end
    value_array.sort
  end

  def to_s

  end
end

#var = MyHash.new
#100_000.times {|i| var[i] = i}
#puts var.keys.size