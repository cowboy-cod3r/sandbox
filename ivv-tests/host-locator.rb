# Required Library
require 'ivv-host-locator'

# Create a Log Object
hosts = IVV::Host::Locator.instance()

# Three ways to access an IP address, returns a String
ip = hosts.props[:landing][:ip]
puts ip
ip = hosts.ip(:landing)  # passing in the symbol
puts ip
ip = hosts.ip("landing") # passing in the string representation of the symbol
puts ip

# Three ways to access a port, returns a String
port = hosts.props[:landing][:port]
puts port
port = hosts.port(:landing)  # passing in the symbol
puts port
port = hosts.port("landing") # passing in the string representation of the symbol
puts port

# Three ways to access the context path, returns a String
context = hosts.props[:landing][:context]
puts context
context = hosts.context(:landing)  # passing in the symbol
puts context
context = hosts.context("landing") # passing in the string representation of the symbol
puts context

# Determine if the connection should be secured, returns a boolean
secured = hosts.props[:landing][:ssl]
puts secured
secured = hosts.secured?(:landing)
puts secured
secured = hosts.secured?("landing")
puts secured

# Generate a URI, returns a URI
uri = hosts.uri(:landing, "https")
puts uri.to_s
uri = hosts.uri("landing", "https")
puts uri.to_s

