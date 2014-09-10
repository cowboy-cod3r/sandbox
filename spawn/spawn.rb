#!/opt/apps/ruby/ruby/bin/ruby

read,write = IO.pipe

#pid = Process.spawn("ruby","child.rb",STDERR => STDOUT)
#pid = Process.spawn("sleep 30")
#
io = nil
test = IO.popen("ruby child.rb") do |stream|
end

puts test.class
write.close
puts read.read
read.close
