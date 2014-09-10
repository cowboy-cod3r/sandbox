#!/opt/apps/ruby/ruby/bin/ruby

original = "hello"
copy = original
copy << " there"
puts copy
puts original

original = "hello"
copy = original
copy += " there"
puts copy
puts original
