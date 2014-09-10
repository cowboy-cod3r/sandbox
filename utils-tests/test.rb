#!/opt/apps/ruby/ruby/bin/ruby

require 'iss-utils'


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Platform
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
puts " Platform Check"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
include ISS::Utils::Platform
puts windows?
puts linux?
puts mac?
puts bsd?
puts solaris?
