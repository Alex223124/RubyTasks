module Version1
  class MyHash
    def initialize(default = nil)
      @key_array = []
      @value_array = []
      @default = default
    end

    def []=(key, value)
      if @key_array.include?(key)
        i = @key_array.index(key)
        @value_array[i] = value
      else
        @key_array << key
        @value_array << value
      end
    end

    def add_many(*args)
      return "please, enter an even number of arguments" if args.size.odd?
      args.each_index { |i| self[args[i - 1]] = args[i] if i.odd? }
    end

    def [](key)
      i = @key_array.index(key)
      i.nil? ? @default : @value_array[i]
    end

    def delete(key)
      if @key_array.include?(key)
        i = @key_array.index(key)
        @key_array.delete_at(i)
        @value_array.delete_at(i)
      else
        'There is no key in MyHash'
      end
    end

    def values
      @value_array
    end

    def keys
      @key_array
    end

    def to_s
      str = '{'
      @key_array.each_index { |i| str << "#{@key_array[i]} => #{@value_array[i]}, " }
      str << '}'
    end

    def length
      @key_array.length
    end

    def clear
      @value_array.clear
      @key_array.clear
    end

    def empty?
      @key_array.empty? ? true : false
    end

    def eql?(otherMyHash)
      otherMyHashKeys = otherMyHash.keys
      otherMyHashValues = otherMyHash.values

      if @key_array.eql?(otherMyHashKeys) && @value_array.eql?(otherMyHashValues)
        return true
      elsif @key_array.size != otherMyHashKeys.size || @value_array.size != otherMyHashValues.size
        return false
      end

      @key_array.each do |elem|
        if otherMyHashKeys.include?(elem)
          i = otherMyHashKeys.index(elem)
          j = @key_array.index(elem)
          return false if @value_array[j] != otherMyHashValues[i]
        else
          return false
        end
      end

      true
    end
  end
end

module Version2
  Pair = Struct.new(:key, :value)

  class MyHash
    def initialize(default = nil)
      @main_array = []
      @const = 50_000
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
        @main_array[index].each_with_index do |p, i|
          return @main_array[index][i] = pair if p.key == pair.key
        end
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
      @size = 0
      @main_array.clear
    end

    def empty?
      @main_array.empty?
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

    def delete(key)
      index = hash_func(key)
      arr = @main_array[index]
      if arr.nil? || arr.empty?
        'There is no key in MyHash'
      else
        arr.each_index { |i| arr.delete_at(i) if arr[i].key == key }
        @size -= 1
      end
    end

    def to_s
      out = []
      @main_array.each do |arr|
        str = ""
        unless arr.nil? || arr.empty?
          arr.each do |pair|
            str << pair.key.inspect
            str << '=>'
            str << pair.value.inspect
          end
          out << str
        end
      end
      "{#{out.join(', ')}}"
    end

    def eql?(other_hash)
      return false unless other_hash.class == MyHash && self.length == other_hash.length

      self.keys.each do |key|
        return false unless other_hash.keys.include?(key) && self[key] == other_hash[key]
      end
      true
    end

    def add_many(*args)
      return "please, enter an even number of arguments" if args.size.odd?
      args.each_index { |i| self[args[i - 1]] = args[i] if i.odd? }
    end
  end
end