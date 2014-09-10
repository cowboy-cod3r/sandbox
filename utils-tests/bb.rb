#!/opt/apps/ruby/ruby/bin/ruby

require 'iss-utils'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# blackbox
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts " Blackbox"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
include ISSBlackBox
bb = BlackBox.new()
#pass   = "Pa$$w0rd"
#e_pass =  bb.encrypt(pass)
e_pass = "qe3JJpj2PToOhFXcJ9oO6Q=="
puts bb.decrypt(e_pass)
