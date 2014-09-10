#!/opt/apps/ruby/ruby/bin/ruby

require 'ivv-drb-client'
require 'json'

node = "172.30.13.201"
port = "8010"
features = IVV::Drb::Objects::Features.new(node,port)
features.instantiate()
puts features.destroy_session(27304332)

