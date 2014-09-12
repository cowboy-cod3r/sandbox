#!/opt/apps/ruby/ruby/bin/ruby
# Required libraries
require 'delegate'


# == Description
# The Stats class
class Stats
  attr_accessor :source

  # ==== Description
  # Constructor
  def initialize
    # Initialize the delegator with an empty array
    # Now, @source can be called with any array method
    @source = SimpleDelegator.new([])
  end

  def stats(records)
    @source.__setobj__(records)

    "Elements:  #{@source.size}\n" +
    " Non-Nil:  #{@source.compact.size}\n" +
    "  Unique:  #{@source.uniq.size}\n"
  end
end

s = Stats.new
puts s.source.size()
puts s.source.class
#puts s.stats(%w{James Edward Gray II})
#puts
#puts s.stats([1, 2, 3, nil, 4, 5, 1, 2])

