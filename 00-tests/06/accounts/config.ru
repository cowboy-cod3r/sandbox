$:.unshift(File.join(File.dirname(__FILE__),"lib"))

# Required Libraries
require 'itriage/services/app'
require 'sinatra'

# Run the Sinatra App
puts self.methods
set :port, 9999
run App
