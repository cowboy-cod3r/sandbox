#!/opt/apps/ruby/ruby/bin/ruby

require 'ivv-drb-client'
require 'date'
require 'json'

# How many tests to execute per machine
range   = 1..1
threads = []

# How many times the test should execute
max       = 1 
max_range = 1..max

# Set the hosts file
hosts_yml     = "humbarger-daily-int-hosts.yml"
hosts_yml_loc = File.join(File.dirname(__FILE__),"hosts",hosts_yml)

# The nodes that will execute the tests
port  = "8010"
nodes = [
  "172.30.13.201",
  "172.30.13.202",
  "172.30.13.203",
  "172.30.13.204",
  "172.30.13.205",
  "172.30.13.206",
  "172.30.13.207",
  "172.30.13.208",
  "172.30.13.209",
  "172.30.13.210",
  "172.30.13.211",
  "172.30.13.212",
  "172.30.13.213",
  "172.30.13.214",
  "172.30.13.215",
  "172.30.13.216",
  "172.30.13.217",
  "172.30.13.218",
  "172.30.13.219",
  "172.30.13.220"
]

features = {}
ret_val = {}
time_diffs = []

max_range.each do |x|
  puts "Executing test #{x} of #{max}"
  start_time = DateTime.now()

  nodes.each do |node|
    range.each do |i|
      threads << Thread.new(i.to_s + node) do |thread|
        features[Thread.current.object_id] = IVV::Drb::Objects::Features.new(node,port)
        features[Thread.current.object_id].instantiate()
        features[Thread.current.object_id].override_hosts(hosts_yml_loc)
        ret_val[Thread.current.object_id] = features[Thread.current.object_id].execute_ivv("--browser","chrome","--performance")
      end
    end
  end
  threads.each do |thread|
    thread.join()
  end

  # Calculate Time Difference
  end_time = DateTime.now()
  diff = ((start_time - end_time) * 24 * 60 * 60).to_i
  time_diffs << diff.abs
end

final = []
ret_val.each do |k,v|
  final.concat(v)
end

results = JSON.generate(ret_val)
results_file = File.join(File.dirname(__FILE__),"results","results.json")
File.open(results_file, 'w') { |file| file.write(results) }


avg = time_diffs.inject{ |sum, el| sum + el }.to_f / time_diffs.size
puts
puts time_diffs.to_json
puts
puts "Average thread time was '#{avg.to_s}' seconds"
