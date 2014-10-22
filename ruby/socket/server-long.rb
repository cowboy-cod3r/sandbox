#!/opt/apps/ruby/ruby/bin/ruby

require 'socket'

# Create
socket = Socket.new(:INET, :STREAM) # Stream is for tc, DGRAM would be for udp

# Bind
addr = Socket.pack_sockaddr_in(7777, 'localhost')
socket.bind(addr)

# Listen
socket.listen(128) # Accept 128 connections

# Accept connections indefinitely
loop do
  # Accept
  conn, _ = socket.accept

  puts "Connection class:"
  puts conn.class
  puts
  puts "Socket fileno:"
  puts socket.fileno
  puts
  puts "Connection fileno:"
  puts conn.fileno
  puts
  puts "Local Address (Server Info):"
  p conn.local_address
  puts
  puts "Remote Address (Client Info):"
  puts conn.remote_address

  # Close the connection
  conn.close
end
