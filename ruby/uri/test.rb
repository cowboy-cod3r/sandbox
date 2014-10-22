#!/opt/apps/ruby/ruby/bin/ruby

require 'uri'

uri = URI.parse("http://www.google.com")
puts uri.port
