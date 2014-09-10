#!/opt/apps/ruby/ruby/bin/ruby
#
# This is a quick way to add all numbers up to 100
# The actual formaula written out is
#
# n(n+1)/2
#
require 'benchmark'

iterations = 100_000

Benchmark.bm do |bm|
  # Using a formula
  bm.report do
    iterations.times do
      n = 100*(100+1)/2
    end
  end

  # Looping
  bm.report do
   iterations.times do
     range = 1..100
     y = 0
     range.each do |x|
       y += 1
     end
   end
  end
end
