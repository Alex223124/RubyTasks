#!/usr/bin/ruby

class MyHash
	
	def initialize(key, value = nil)
		@key_array = []
		@value_array = []
		@key_array.push(key)
		@value_array.push(value)
	end

	def add(key, value = nil)
		if @key_array.include?(key)
			puts "There is key in hash"
		else
			@key_array.push(key)
			@value_array.push(value)
		end
	end

	def []=(key, value = nil)
		self.add(key, value)
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
		(0...@key_array.length).each { |i| puts "#{@key_array[i]} => #{@value_array[i]}"}
	end

	def length
		@key_array.length	
	end

end
