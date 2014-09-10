#!/opt/apps/ruby/ruby/bin/ruby

require 'socket'
require 'json'

def get_ret_val()
  ret_val            = {}
  ret_val[:hostname] = Socket.gethostname()
  STDOUT.puts ret_val.to_json
  return ret_val
end

get_ret_val
