#!/opt/apps/ruby/ruby/bin/ruby

# Loop from 0 to 100, exclude 0 and 100 and only print even number
#
range = 0...100

range.each do |x|
  if x.odd? || x == 0
    next
  end
  puts x
end

for i in range 
  next if i.odd? || i == 0
  puts i
end
