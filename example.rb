#!/usr/bin/env ruby
# An example for how to interact with the JarHub update server from ruby
# Author: Chris Eberle <chris.eberle@issinc.com>
#
# Make sure to run these before you run this:
# $ gem install thrift
# $ gem install thin
#
# NOTE: The "gen-rb" directory can be generated with the following command:
# $ thrift --gen rb JarHubUpdate.thrift
#
# This assumes you have the thrift compiler installed locally, of course.
# Otherwise just go ahead and use the attached version.

require 'rubygems'
gem 'thrift', '=0.9.1'

require 'thrift'
require 'date'

# Change these as needed
generated_files_directory = File.join(File.expand_path(File.dirname(__FILE__)), 'gen-rb')
update_host = "172.20.11.153"
update_port = 8010

# Loves me my assertions
class AssertionError < RuntimeError; end
def assert(condition, message)
  raise AssertionError.new(message) unless condition
end

# Because screw offsets
def nice_uptime(uptime)
  minutes, seconds = uptime.divmod(60)
  hours, minutes = minutes.divmod(60)
  days, hours = hours.divmod(24)
  "%d days, %d hours, %d minutes and %d seconds" % [days, hours, minutes, seconds]
end

# Quickly print a version descriptor
def print_version(name, vd)
  puts "*" * 79
  puts "Latest #{name} version:      #{vd.version}"
  puts "Latest #{name} build date:   " + Time.at(vd.timestamp / 1000).to_datetime.to_s
  puts "Latest #{name} download URL: #{vd.url}"
  puts "Latest #{name} filename:     #{vd.filename}"
end

# Include the generated thrift files
$:.unshift generated_files_directory
require 'jar_hub_update_constants'
require 'jar_hub_update_types'
require 'jar_hub_update_service'
$:.shift

# Set up the client
sock = Thrift::Socket.new(update_host, update_port)
transport = Thrift::BufferedTransport.new(sock)
protocol = Thrift::BinaryProtocol.new(transport)
client = JarHubUpdateService::Client.new(protocol)

# Open the transport
puts "Opening connection to #{update_host}:#{update_port}..."
transport.open()

begin
  # Ping it, see if it's alive
  client.ping()
  puts "Successfully connected"

  # Ensure that the protocol version on the server is what we're expecting
  assert client.getServerProtocolVersion == PROTOCOL_VERSION, 'Incorrect protocol version'
  puts "Protocol version matches"

  # Get the uptime of the update server (milliseconds since the epoch)
  uptime = client.getServerUptime
  assert uptime >= 0, 'Invalid uptime'
  puts "*" * 79
  puts "Update server uptime: " + nice_uptime(uptime)

  # Get the latest version of jarhub-server
  # NOTE: vd = version descriptor
  vd = client.getLatestVersion(update_host)
  print_version('jarhub-server', vd)

  # Get the latest version of jarhub-debug
  vd = client.getLatestDebuggerVersion(update_host)
  print_version('jarhub-debug', vd)

  # Get the latest version of jarhub-proxy
  vd = client.getLatestProxyVersion(update_host)
  print_version('jarhub-proxy', vd)

ensure
  # Close the transport, we're done
  transport.close()
end
