#!/opt/apps/ruby/ruby/bin/ruby
require 'json'
require 'date'

json_file = File.join(File.dirname(__FILE__),"results","results.json")
time_diffs = []
passed = []
failed = []

File.open(json_file,'r') do |file|
  json = JSON.parse(file.read)
  json.each do |k,results|
    results.each do |result|
      if result["status"] == "Passed"
        passed << result
        start_time = DateTime.strptime(result["start_time"],'%FT%T%:z')
        end_time   = DateTime.strptime(result["end_time"],'%FT%T%:z')
        diff       = ((start_time - end_time) * 24 * 60 * 60).to_i
        time_diffs << diff.abs
      else
        failed << result
      end
    end
  end
end

avg = time_diffs.inject{ |sum, el| sum + el }.to_f / time_diffs.size
puts "Passed: #{passed.count}"
puts "Failed: #{failed.count}"
puts "Raw Data based on Passed Tests: #{time_diffs.to_json}"
puts "Longest Test based on Passed Tests was '#{time_diffs.max}' seconds"
puts "Shortest Test based on Passed Tests was '#{time_diffs.min}' seconds"
puts "Average test based on Passed Tests '#{avg.to_s}' seconds"
