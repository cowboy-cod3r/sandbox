#!/opt/apps/ruby/ruby/bin
require 'uri'

# I am the method defined somewhere
def call_me(url)
  if block_given?
    uri = URI(url)
    test = yield(uri.scheme, uri.host, uri.port)
    puts "SEAN: #{test}"
  else
    puts "nothing given"
  end
end

outside = "hello"
call_me("http://192.168.211.11:8443/workflow") do |scheme,host,port|
    puts scheme
    puts host
    puts port
    puts outside
    outside = "goodbye"
end
puts outside

call_me("http")
