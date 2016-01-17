#!/usr/bin/ruby

class MyHash
	
	def initialize(default = nil)
		@key_array = []
		@value_array = []
		@default = default
	end

	def add(key, value = @default)
		if @key_array.include?(key)
			puts "There is key in hash"
		else
			@key_array.push(key)
			value.nil?? @value_array.push(@default) : @value_array.push(value)
		end
	end

	def []=(key, value = @default)
		self.add(key, value)
	end

	def add_many(*args)
		args.each_index { |i| self.add(args[i-1], args[i]) if i % 2 != 0 }
		if args.size % 2 != 0
			@value_array.push(@default) 
			@key_array.push(args.last)
		end
	end

	def [](key)
		if @key_array.include?(key)
			i = @key_array.index(key)
			@value_array[i]
		else
			puts "There is no key in hash"
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

end
