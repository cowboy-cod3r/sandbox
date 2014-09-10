#!/opt/apps/ruby/ruby/bin/ruby

sentence = "Hello My Name is Sean"
delim = " "
puts "Original: " + sentence
puts "Reversed: " + sentence.split(delim).reverse().join(delim)
