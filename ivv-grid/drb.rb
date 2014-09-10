#!/opt/apps/ruby/ruby/bin/ruby

require 'ivv-drb-client'
require 'date'

# How many tests to execute per machine
range = 1..1
threads = []

# How many times the test should execute
max = 1 # Joel wants this at 100
max_range = 1..1

# The nodes that will execute the tests
nodes = ["172.30.13.201"]
port = "8010"

features = {}
ret_val = {}
time_diffs = []

max_range.each do |x|
  puts "Executing test #{x} of #{max}"
  start_time = DateTime.now()

  nodes.each do |node|
    range.each do |i|
      threads << Thread.new(i) do |thread|
        features[i] = IVV::Drb::Objects::Features.new(node,port)
        features[i].instantiate()
        ret_val[i]  = features[i].execute_ivv("--browser","chrome","--performance")
        #ret_val[i]  = features[i].execute_ivv("--browser","chrome")

        #if ! ret_val.nil? && ! ret_val.empty?
        #  puts "Data Should be Inserted"
        #else
        #  puts "There was no data to insert"
        #end
      end
    end
    threads.each do |thread|
      thread.join()
    end
  end

  # Calculate Time Difference
  end_time = DateTime.now()
  diff = ((start_time - end_time) * 24 * 60 * 60).to_i
  time_diffs << diff.abs


  #ret_val.each do |k,v|
  #  puts v
  #end
  #puts x
end

avg = time_diffs.inject{ |sum, el| sum + el }.to_f / time_diffs.size
puts
puts time_diffs.to_json
puts
puts "Average test time was '#{avg.to_s}' seconds"
puts
