#!/opt/apps/ruby/ruby/bin/ruby

require 'ivv-drb-client'
require 'date'
require 'json'

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

ret_val = []

total_sessions = 0
nodes.each do |node|
  features = IVV::Drb::Objects::Features.new(node,port)
  features = features.instantiate()
  session = features.session_info()
  json = JSON::parse(session)
  total_sessions = total_sessions + json["data"]["sessions_count"] 
end

puts "ROLLUP INFO"
puts "  Total Nodes: #{nodes.count}"
puts "  Total Sessions Running: #{total_sessions}"

if ARGV.include?("--show-node-info")
  puts "NODE INFO"
  nodes.each do |node|
    features = IVV::Drb::Objects::Features.new(node,port)
    features = features.instantiate()
    session = features.session_info()
    json = JSON::parse(session)
    puts "#{node} Session Status"
    puts "============================================"
    puts "Current Sessions Running: #{json["data"]["sessions_count"]}"
    puts "Max Sessions Allowed:     #{json["data"]["max"]}"
    puts "Browsers Supported:       #{json["data"]["supported_browsers"].join}"

    if ARGV.include?("--show-session-details")
      if json["data"]["sessions"].count > 0
        puts "  SESSIONS"
        json["data"]["sessions"].each do |session|
          session = JSON::parse(session)
          puts "    SESSION ID: #{session["id"]}"
          puts "      pid:        #{session["pid"]}"
          puts "      thread:     #{session["thread_id"]}"
          puts "      status:     #{session["status"]}"
          puts "      start time: #{session["start_time"]}"
        end
        puts
      end
    end
    puts
  end
end
