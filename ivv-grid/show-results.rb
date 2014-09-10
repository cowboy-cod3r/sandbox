#!/opt/apps/ruby/ruby/bin/ruby
require 'json'
require 'date'

json_file = File.join(File.dirname(__FILE__),"results","results.json")

File.open(json_file,'r') do |file|
  json = JSON.parse(file.read)
  json.each do |k,results|
    results.each do |result|
        if defined?(result["reports"]["pretty"])
          puts result["reports"]["pretty"]
        end
    end
  puts
  end
end
