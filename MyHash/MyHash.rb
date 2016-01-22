#!/usr/bin/ruby

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
    args.each_index { |i| self[args[i - 1]] = args[i] if i.odd? }
    self[args.last] = @default if args.size.odd?
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
