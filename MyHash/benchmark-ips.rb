require "benchmark/ips"
require_relative 'MyHash.rb'
include Version2

keys_and_values = {}
array = []
h = MyHash.new
100_000.times do |i|
  a = rand(100)
  keys_and_values[i] = a
  array[i] = a
  h[i] = a
end

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
  x.report('RubyArray_get') { ruby_array_get(array, a) }
  x.compare!
end