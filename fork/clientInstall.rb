#!/opt/apps/ruby/ruby/bin/ruby
$:.unshift(File.dirname(__FILE__))
require 'pipe'

puts "I am the child #{Process.pid}"

pipe = IvvPipe.instance()

$writer.write([1,2,3])
$writer.close()
