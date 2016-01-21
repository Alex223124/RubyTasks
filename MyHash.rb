#!/usr/bin/ruby

require 'benchmark/ips'

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

  def [](*args)
    if args.size == 1
      i = @key_array.index(args[0])
      i.nil? ? @default : @value_array[i]
    else
      add_many(args)
    end
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

keys_and_values = {}
array = []
h = MyHash.new
1000.times { |i|
  a = rand(100)
  keys_and_values[i] = a
  array[i] = a
  h[i] = a
}

def my_hash_set(args)
  hash = MyHash.new
  args.each do |key, value|
    hash[key] = value
  end
end

def my_hash_get(args, key)
  args[key]
end

def ruby_array_get(args, key)
  args[key]
end

def ruby_hash_set(args)
  hash = Hash.new
  args.each do |key, value|
    hash[key] = value
  end
end

Benchmark.ips do |x|
  x.report('MyHash_set') { my_hash_set(keys_and_values) }
  x.report('RubyHash_set') { ruby_hash_set(keys_and_values) }
  x.compare!
end

Benchmark.ips do |x|
  a = rand(100)
  x.report('MyHash_get') { my_hash_get(h, a) }
  x.report('RubyHash_get') { ruby_array_get(array, a) }
  x.compare!
end
