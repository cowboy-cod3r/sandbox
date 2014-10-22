#!/opt/apps/ruby/ruby/bin/ruby

# Base64 is a binary-to-text encoding scheme
# that represents binary data in an ASCII string format
# by translating it to radix-64 representation

# Required Libraries
require 'base64'

str = "sean"

# Encode it
encoded = Base64.strict_encode64(str)
puts "Encoded: #{encoded}"
puts

decoded = Base64.strict_decode64(encoded)
puts "Decoded: #{decoded}"