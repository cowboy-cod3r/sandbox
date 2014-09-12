#!/opt/apps/ruby/ruby/bin/ruby

# 5. Print all odd number from 1 to 100

range = 1..100

range.each do |x|
  puts x if (x%2 != 0)
end