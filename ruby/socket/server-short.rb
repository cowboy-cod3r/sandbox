#!/opt/apps/ruby/ruby/bin/ruby

require 'socket'

socket = TCPServer.new(7777)

# Accept connections indefinitely
Socket.accept_loop(socket) do |conn|
  p conn

  # Close
  conn.close()
end
