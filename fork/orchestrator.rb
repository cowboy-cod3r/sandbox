#!/opt/apps/ruby/ruby/bin/ruby
$:.unshift(File.dirname(__FILE__))
require 'pipe'
puts "I am the parent #{Process.pid}"

#pipe = IvvPipe.instance()
$reader,$writer = IO.pipe

fork do
  system("ruby clientInstall.rb")
end

Process.wait
puts "The parent is done"
data = $reader.read
#puts data
