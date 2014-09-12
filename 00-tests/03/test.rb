#!/opt/apps/ruby/ruby/bin/ruby

# 3.  Reverse all the words in this sentence as well as the letters.
# 4.  Reverse all the words in this sentence as well as the letters without using the reverse method.

# 3.
sentence = "Reverse all the words in this sentence as well as the letters."
puts sentence.reverse
puts

# 4.
sentence = "Reverse all the words in this sentence as well as the letters."
s_ary    = sentence.split(/\s/).collect {|x| x.reverse}
puts s_ary.reverse.join(" ")