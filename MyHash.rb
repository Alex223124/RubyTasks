#!/usr/bin/ruby

require 'benchmark/ips'

class MyHash
	
	def initialize(default = nil)
		@key_array = []
		@value_array = []
		@default = default
	end

	def []=(key, value = @default)
		if @key_array.include?(key)
			puts "There is key in hash"
		else
			@key_array<<key
			@value_array<<value
		end
	end

	def add_many(*args)
		args.each_index { |i| self.add(args[i-1], args[i]) if i % 2 != 0 }
		if args.size % 2 != 0
			@value_array.push(@default) 
			@key_array.push(args.last)
		end
	end

	def [](*args)
		if args.size == 1
			if @key_array.include?(key)
				i = @key_array.index(key)
				@value_array[i]
			else
				puts "There is no key in hash"
			end
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
			puts "There is no key in hash"
		end
	end

	def values
		@value_array
	end

	def keys
		@key_array
	end

	def to_s
		print "{"
		@key_array.each_index { |i| print "#{@key_array[i]} => #{@value_array[i]}, "}
		print "}"
		puts
	end

	def length
		@key_array.length	
	end

	def clear
	  @value_array.clear
		@key_array.clear
	end

	def empty?
		@key_array.empty?? true : false 
	end

end

keys_and_values = { a: 1, b: 2, c: 3 }

def my_hash(args)
  hash = MyHash.new
  args.each do |key, value|
    hash[key] = value
  end
end

def ruby_hash(args)
  hash = Hash.new
  args.each do |key, value|
    hash[key] = value
  end
end

Benchmark.ips do |x|
  x.report("MyHash") { my_hash(keys_and_values) }
  x.report("RubyHash") { ruby_hash(keys_and_values) }
  x.compare!
end

var = MyHash.new
puts
puts var.empty?