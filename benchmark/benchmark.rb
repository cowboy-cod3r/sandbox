# Benchmarking allows code execution to be timed and result tabulated

# Required Libraries
require 'benchmark'

# Included modules
include Benchmark

# String to get the elngth of
string = "Stormy Weather"

# Store the method name in a variable and make 4 different
# types of method calls to the same method and see which one
# is faster
m = string.method(:length)
bm(6) do |x|
  x.report("direct") { 100_000.times { string.length        } }
  x.report("call")   { 100_000.times { m.call               } }
  x.report("send")   { 100_000.times { string.send(:length) } }
  x.report("eval")   { 100_000.times { eval "string.length" } }
end