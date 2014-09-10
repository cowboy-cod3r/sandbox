#!/opt/apps/ruby/ruby/bin/ruby

range = 1..3
range.each do |x|
  io      = IO.popen("ruby child.rb")
  ret_val = io.read
  puts ret_val
  io.close
end
#Process.wait()

puts "done"
